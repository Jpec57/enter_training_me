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
  WorkoutEditBloc(this.trainingRepository, Training training)
      : super(WorkoutEditState(training: training));

  @override
  Stream<WorkoutEditState> mapEventToState(
    WorkoutEditEvent event,
  ) async* {
    if (event is ChangedExerciseEvent) {
    } else if (event is SwitchedExerciseEvent) {
      List<ExerciseCycle> newCycles = [];
      for (var cycle in state.training.cycles) {
        List<RealisedExercise> cycleExos = [...cycle.exercises];
        RealisedExercise tmpExo = cycleExos[event.secondIndex];
        cycleExos[event.secondIndex] = cycleExos[event.firstIndex];
        cycleExos[event.firstIndex] = tmpExo;
        newCycles.add(cycle.copyWith(exercises: cycleExos));
      }
      yield state.copyWith(
          training: state.training.copyWith(cycles: newCycles),
          hasMadeChanges: true);
    } else if (event is RemovedExerciseEvent) {
      List<ExerciseCycle> newCycles = [];
      for (var cycle in state.training.cycles) {
        List<RealisedExercise> cycleExos = [...cycle.exercises];
        cycleExos.removeAt(event.exoIndex);
        newCycles.add(cycle.copyWith(exercises: cycleExos));
      }
      yield state.copyWith(
          training: state.training.copyWith(cycles: newCycles),
          hasMadeChanges: true);
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
        if (state.training.id != null) {
          try {
            Training? training;
            if (state.training.isOfficial) {
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
        } else {
          Get.snackbar("Error", "An error occurred. Please contact us.");
        }
      }
    }
  }
}
