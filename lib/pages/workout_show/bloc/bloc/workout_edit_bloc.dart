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
            training: training, isEditting: isEditingAtStartAlready)) {
    on<ChangedExerciseEvent>(_onChangedExerciseEvent);
    on<AddedExerciseEvent>(_onAddedExerciseEvent);
    on<SwitchedExerciseEvent>(_onSwitchedExerciseEvent);
    on<RemovedExerciseEvent>(_onRemovedExerciseEvent);
    on<ChangedNbLoopsEvent>(_onChangedNbLoopsEvent);
    on<ToggledEditModeEvent>(_onToggledEditModeEvent);
    on<RenamedWorkoutEvent>(_onRenamedWorkoutEvent);
    on<SavedTrainingChangesEvent>(_onSavedTrainingChangesEvent);
  }

  void _onChangedExerciseEvent(
      ChangedExerciseEvent event, Emitter<WorkoutEditState> emit) {
    List<RealisedExercise> newExoList = [...state.training.exercises];
    newExoList[event.exoIndex] = event.exo;
    emit(state.copyWith(
        hasMadeChanges: true,
        training: state.training.copyWith(exercises: newExoList)));
  }

  void _onAddedExerciseEvent(
      AddedExerciseEvent event, Emitter<WorkoutEditState> emit) {
    Training currentTraining = state.training;
    List<RealisedExercise> exos = [...currentTraining.exercises];
    exos.add(event.exo);
    currentTraining = currentTraining.copyWith(exercises: exos);

    emit(state.copyWith(
      training: currentTraining,
    ));
  }

  void _onSwitchedExerciseEvent(
      SwitchedExerciseEvent event, Emitter<WorkoutEditState> emit) {
    List<RealisedExercise> newExoList = [...state.training.exercises];
    RealisedExercise tmpExo = newExoList[event.secondIndex];
    newExoList[event.secondIndex] = newExoList[event.firstIndex];
    newExoList[event.firstIndex] = tmpExo;
    emit(state.copyWith(
        training: state.training.copyWith(exercises: newExoList),
        hasMadeChanges: true));
  }

  void _onRemovedExerciseEvent(
      RemovedExerciseEvent event, Emitter<WorkoutEditState> emit) {
    List<RealisedExercise> newExoList = [...state.training.exercises];
    newExoList.removeAt(event.exoIndex);
    emit(state.copyWith(
        training: state.training.copyWith(exercises: newExoList),
        hasMadeChanges: true));
  }

  void _onChangedNbLoopsEvent(
      ChangedNbLoopsEvent event, Emitter<WorkoutEditState> emit) {
    if (event.nbLoops > 0) {
      emit(state.copyWith(
          training: state.training.copyWith(numberOfLoops: event.nbLoops)));
    }
  }

  void _onToggledEditModeEvent(
      ToggledEditModeEvent event, Emitter<WorkoutEditState> emit) {
    emit(state.copyWith(isEditting: !state.isEditting));
  }

  void _onRenamedWorkoutEvent(
      RenamedWorkoutEvent event, Emitter<WorkoutEditState> emit) {
    emit(state.copyWith(
        hasMadeChanges: true,
        isEditting: true,
        training: state.training.copyWith(name: event.name)));
  }

  void _onSavedTrainingChangesEvent(
      SavedTrainingChangesEvent event, Emitter<WorkoutEditState> emit) async {
    if (!state.hasMadeChanges) {
      emit(state.copyWith(isEditting: false));
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
          emit(state.copyWith(training: state.training, isEditting: false));
        }
      } on DioError catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
