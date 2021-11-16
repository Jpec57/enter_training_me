import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page_arguments.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'workout_edit_event.dart';
part 'workout_edit_state.dart';

class WorkoutEditBloc extends Bloc<WorkoutEditEvent, WorkoutEditState> {
  final TrainingRepository trainingRepository;
  WorkoutEditBloc(this.trainingRepository, Training training,
      {bool isEditingAtStartAlready = false})
      : super(WorkoutEditState(
            training: training, isEditting: isEditingAtStartAlready));

  @override
  Stream<WorkoutEditState> mapEventToState(
    WorkoutEditEvent event,
  ) async* {
    if (event is ChangedExerciseEvent) {
      List<RealisedExercise> newExoList = [...state.training.exercises];
      newExoList[event.exoIndex] = event.exo;
      yield state.copyWith(
          hasMadeChanges: true,
          training: state.training.copyWith(exercises: newExoList));
      // } else if (event is ChangedRestEvent) {
      //   List<RealisedExercise> newExoList = [...state.training.exercises];
      //   RealisedExercise exo = newExoList[event.exerciseIndex];
      //   newExoList[event.exerciseIndex] =
      //       exo.copyWith(restBetweenSet: event.rest);
      //   yield state.copyWith(
      //       hasMadeChanges: true,
      //       training: state.training.copyWith(exercises: newExoList));
    } else if (event is AddedExerciseEvent) {
      yield _mapAddedExoEventToState(event);
    } else if (event is SwitchedExerciseEvent) {
      List<RealisedExercise> newExoList = [...state.training.exercises];
      RealisedExercise tmpExo = newExoList[event.secondIndex];
      newExoList[event.secondIndex] = newExoList[event.firstIndex];
      newExoList[event.firstIndex] = tmpExo;
      yield state.copyWith(
          training: state.training.copyWith(exercises: newExoList),
          hasMadeChanges: true);
    } else if (event is RemovedExerciseEvent) {
      List<RealisedExercise> newExoList = [...state.training.exercises];
      newExoList.removeAt(event.exoIndex);
      yield state.copyWith(
          training: state.training.copyWith(exercises: newExoList),
          hasMadeChanges: true);
    } else if (event is ChangedNbLoopsEvent) {
      if (event.nbLoops > 0) {
        yield state.copyWith(
            training: state.training.copyWith(numberOfLoops: event.nbLoops));
      }
    } else if (event is ToggledEditModeEvent) {
      yield state.copyWith(isEditting: !state.isEditting);
    } else if (event is RenamedWorkoutEvent) {
      yield state.copyWith(
          hasMadeChanges: true,
          isEditting: true,
          training: state.training.copyWith(name: event.name));
    } else if (event is SavedTrainingChangesEvent) {
      if (!state.hasMadeChanges) {
        yield state.copyWith(isEditting: false);
      } else {
        try {
          Training? training;
          if (state.training.isOfficial || state.training.id == null) {
            training = await trainingRepository
                .postUserTraining(state.training.toJsonForCreation());
            if (training != null) {
              if (training.id != null) {
                await trainingRepository.saveTrainingAction(training.id!);
              }

              Get.offNamedUntil(WorkoutShowPage.routeName,
                  ModalRoute.withName(HomePage.routeName),
                  arguments:
                      WorkoutShowPageArguments(referenceTraining: training));
            }
          } else {
            training = await trainingRepository.patch(
                state.training.id!, state.training.toJson());
          }

          if (training != null) {
            yield state.copyWith(training: state.training, isEditting: false);
          }
        } on DioError catch (e) {
          Get.snackbar("Error", e.toString());
        }
      }
    }
  }

  WorkoutEditState _mapAddedExoEventToState(AddedExerciseEvent event) {
    Training currentTraining = state.training;
    List<RealisedExercise> exos = [...currentTraining.exercises];
    exos.add(event.exo);
    currentTraining = currentTraining.copyWith(exercises: exos);

    return state.copyWith(
      training: currentTraining,
    );
  }
}
