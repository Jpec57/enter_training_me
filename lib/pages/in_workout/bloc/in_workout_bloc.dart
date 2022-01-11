import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/community/community_page.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_view_enum.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'in_workout_state.dart';

part 'in_workout_event.dart';

class InWorkoutBloc extends HydratedBloc<InWorkoutEvent, InWorkoutState> {
  final TrainingRepository trainingRepository;
  final GoRouter router;

  InWorkoutBloc(this.router, this.trainingRepository, int? referenceTrainingId,
      Training realisedTraining)
      : super(InWorkoutState(
            referenceTrainingId: referenceTrainingId,
            realisedTraining: realisedTraining)) {
    on<AddedExoEvent>(_onAddedExo);
    on<ChangedRefRepsEvent>(_onChangedRefRepsEvent);
    on<ChangedNbLoopsEvent>(_onChangedNbLoops);
    on<ChangedTrainingNameEvent>(_onChangedTrainingName);
    on<TrainingLeftEvent>(_onTrainingLeftEvent);
    on<TrainingEndedEvent>(_onTrainingEndedEvent);
    on<ResetRepEvent>(_onResetRepEvent);
    on<ChangedRefWeightEvent>(_onChangedRefWeightEvent);
    on<TimerTickEvent>(_onTimerTickEvent);
    on<AddedRepEvent>(_onAddedRepEvent);
    on<RemovedRepEvent>(_onRemovedRepEvent);
    on<ChangedRestEvent>(_onChangedRestEvent);
    on<ChangedExoEvent>(_onChangedExoEvent);
    on<ChangedRestBetweenLoopsEvent>(_onChangedRestBetweenLoopsEvent);
    on<ChangedViewEvent>(_onChangedViewEvent);
    on<ChangedNbSetEvent>(_onChangedNbSetEvent);
    on<RestDoneEvent>(_onRestDoneEvent);
    on<ExerciseDoneEvent>(_onExerciseDoneEvent);
  }

  @override
  InWorkoutState? fromJson(Map<String, dynamic> json) {
    return InWorkoutState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(InWorkoutState state) {
    return state.toJson();
  }

  void _onExerciseDoneEvent(
      ExerciseDoneEvent event, Emitter<InWorkoutState> emit) async {
    bool isSoundOn = await const FlutterSecureStorage()
            .read(key: StorageConstants.soundInWorkoutKey) ==
        StorageConstants.soundInWorkoutOn;
    if (isSoundOn) {
      FlutterTts flutterTts = FlutterTts();
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.isLanguageAvailable("en-US");
      String? nextExoName = state.nextExo?.exerciseReference.name;
      if (nextExoName != null) {
        _speak(flutterTts, "Next exercise: " + nextExoName);
      }
    }
    emit(state.copyWith(
        reallyDoneReps: state.currentExo!.isIsometric
            ? (state.reallyDoneReps)
            : state.currentSet.reps,
        currentView: InWorkoutView.inRestView));
  }

  // Future<void> savingTrainingContext() async {
  //   debugPrint("Saving context");
  //   //Current Exo, Set, isResting or not
  //   // var box = await Hive.openBox('trainingBox');
  //   var box = await Hive.openBox('tBox');
  //   print(state.realisedTraining);
  //   box.put('currentExoIndex', state.currentExoIndex);
  //   box.put('currentSetIndex', state.currentSetIndex);

  // }

  void _onRestDoneEvent(
      RestDoneEvent event, Emitter<InWorkoutState> emit) async {
    // In loop training, we must additionate all reps
    int offset = 0;
    if (state.realisedTraining.numberOfLoops > 1 &&
        state.currentCycleIndex > 0) {
      offset = state.currentSet.reps;
    }
    List<RealisedExercise> doneExos =
        updateSet(doneReps: state.reallyDoneReps + offset);

    if (state.isEndOfWorkout) {
      Training? training = await saveTraining();
      emit(state.copyWith(isEnd: true, realisedTrainingId: training?.id));
    } else {
      //Saving state in case we lose the context
      // savingTrainingContext();
    }
    emit(state.copyWith(
        isEnd: state.isEndOfWorkout,
        currentCycleIndex: state.nextCycleIndex,
        currentSetIndex: state.nextSetIndex,
        currentExoIndex: state.nextExoIndex,
        currentView: InWorkoutView.inExerciseView,
        realisedTraining:
            state.realisedTraining.copyWith(exercises: doneExos)));
  }

  void _onChangedNbSetEvent(
      ChangedNbSetEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapChangedNbSetEventToState(event));
  }

  void _onChangedViewEvent(
      ChangedViewEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapChangedViewEventToState(event));
  }

  void _onChangedRestBetweenLoopsEvent(
      ChangedRestBetweenLoopsEvent event, Emitter<InWorkoutState> emit) async {
    emit(state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(
            restBetweenCycles: event.seconds > 0 ? event.seconds : 5)));
  }

  void _onChangedExoEvent(
      ChangedExoEvent event, Emitter<InWorkoutState> emit) async {
    RealisedExercise previousExo = state.currentExo!;
    RealisedExercise newExo =
        state.currentExo!.copyWith(exerciseReference: event.exo);
    List<RealisedExercise> doneExos = [...state.realisedTraining.exercises];
    if (state.currentSetIndex == 0) {
      doneExos[state.currentExoIndex] = newExo;
      emit(state.copyWith(
          realisedTraining:
              state.realisedTraining.copyWith(exercises: doneExos)));
    } else {
      doneExos[state.currentExoIndex] = previousExo.copyWith(
          sets: previousExo.sets.sublist(0, state.currentSetIndex));

      if (state.currentSetIndex <= newExo.sets.length) {
        newExo =
            newExo.copyWith(sets: newExo.sets.sublist(state.currentSetIndex));
      } else {
        newExo = newExo.copyWith(sets: [newExo.sets.last]);
      }
      doneExos.insert(state.currentExoIndex + 1, newExo);
      emit(state.copyWith(
          realisedTraining:
              state.realisedTraining.copyWith(exercises: doneExos)));
      emit(state.copyWith(
          currentExoIndex: state.currentExoIndex + 1, currentSetIndex: 0));
    }
  }

  void _onChangedRestEvent(
      ChangedRestEvent event, Emitter<InWorkoutState> emit) async {
    Training? modifiedTraining = state.realisedTraining;
    List<RealisedExercise> exercises = [...state.realisedTraining.exercises];
    RealisedExercise doneExo =
        state.currentExo!.copyWith(restBetweenSet: event.rest);

    exercises[state.currentExoIndex] = doneExo;
    emit(state.copyWith(
        realisedTraining: modifiedTraining.copyWith(exercises: exercises)));
  }

  void _onTimerTickEvent(
      TimerTickEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapTimerTickEventToState(event));
  }

  void _onAddedRepEvent(
      AddedRepEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapAddedRepEventToState(event));
  }

  void _onRemovedRepEvent(
      RemovedRepEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapRemoveRepEventToState(event));
  }

  void _onChangedRefWeightEvent(
      ChangedRefWeightEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapChangedRefWeightEventToState(event));
  }

  void _onChangedRefRepsEvent(
      ChangedRefRepsEvent event, Emitter<InWorkoutState> emit) async {
    emit(_mapChangedRefRepsEventToState(event));
  }

  void _onResetRepEvent(ResetRepEvent event, Emitter<InWorkoutState> emit) {
    emit(state.copyWith(reallyDoneReps: 0));
  }

  void _onTrainingEndedEvent(
      TrainingEndedEvent event, Emitter<InWorkoutState> emit) async {
    Training? training = await saveTraining();
    emit(state.copyWith(realisedTrainingId: training?.id));
    emit(state.copyWith(isEnd: true));
  }

  void _onTrainingLeftEvent(
      TrainingLeftEvent event, Emitter<InWorkoutState> emit) async {
    //Erase all sets above the current one and save training with query
    router.go(CommunityPage.routeName);
  }

  void _onChangedTrainingName(
      ChangedTrainingNameEvent event, Emitter<InWorkoutState> emit) async {
    Map<String, dynamic> nameData = {"name": event.name};
    if (state.realisedTrainingId != null) {
      try {
        Training? training =
            await trainingRepository.patch(state.realisedTrainingId!, nameData);
        if (training != null) {
          emit(state.copyWith(
              realisedTraining:
                  state.realisedTraining.copyWith(name: event.name)));
        }
      } on DioError catch (e) {
        Get.snackbar("Error", e.toString());
      }
    } else {
      emit(state.copyWith(
          realisedTraining: state.realisedTraining.copyWith(name: event.name)));
    }

    emit(state);
  }

  void _onChangedNbLoops(
      ChangedNbLoopsEvent event, Emitter<InWorkoutState> emit) {
    if (event.nbLoops > 0) {
      emit(state.copyWith(
          realisedTraining:
              state.realisedTraining.copyWith(numberOfLoops: event.nbLoops)));
    }
  }

  void _onAddedExo(AddedExoEvent event, Emitter<InWorkoutState> emit) {
    int nextExoIndex = state.currentExoIndex;
    Training currentTraining = state.realisedTraining;
    if (currentTraining.exercises.isNotEmpty) {
      List<RealisedExercise> exos = [...currentTraining.exercises];
      exos.insert(state.currentExoIndex + 1, event.exo);
      currentTraining = currentTraining.copyWith(exercises: exos);
      nextExoIndex++;
    } else {
      currentTraining = currentTraining.copyWith(exercises: [event.exo]);
    }

    emit(state.copyWith(
        realisedTraining: currentTraining,
        currentExoIndex: nextExoIndex,
        currentSetIndex: 0));
    emit(_mapChangedViewEventToState(
        ChangedViewEvent(event.tabController, InWorkoutView.inExerciseView)));
  }

  Future _speak(FlutterTts flutterTts, String text) async {
    await flutterTts.speak(text);
  }

  Future<Training?> saveTraining() async {
    Training? training;
    try {
      Training toSaveTraining = state.realisedTraining;
      if (toSaveTraining.numberOfLoops > 1) {
        int nbDoneCycles = state.currentCycleIndex + 1;
        List<RealisedExercise> realisedExercises = [];
        for (var exo in toSaveTraining.exercises) {
          List<ExerciseSet> realisedSets = [];
          for (var set in exo.sets) {
            realisedSets.add(set.copyWith(reps: set.reps ~/ nbDoneCycles));
          }
          realisedExercises.add(exo.copyWith(sets: realisedSets));
        }
        toSaveTraining =
            state.realisedTraining.copyWith(exercises: realisedExercises);
      }
      //TODO save change in referenceTraining with a patch request
      training =
          await trainingRepository.postUserTraining(toSaveTraining.toJson());
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
      //TODO Save in local storage to resend later
    }
    return training;
  }

  List<RealisedExercise> updateSet(
      {int? doneReps,
      double? weight,
      bool updateNextSets = false,
      int? nbWantedSets}) {
    List<ExerciseSet> doneSets = [...state.currentExo!.sets];
    if (nbWantedSets != null) {
      int currentSetLength = doneSets.length;
      if (nbWantedSets > currentSetLength) {
        for (int i = currentSetLength; i < nbWantedSets; i++) {
          doneSets.add(doneSets[currentSetLength - 1]);
        }
      } else {
        doneSets =
            doneSets.sublist(0, max(state.currentSetIndex + 1, nbWantedSets));
      }
    }
    ExerciseSet doneCurrentSet =
        state.currentSet.copyWith(reps: doneReps, weight: weight);
    doneSets[state.currentSetIndex] = doneCurrentSet;
    if (updateNextSets) {
      for (var i = state.currentSetIndex + 1; i < doneSets.length; i++) {
        doneSets[i] = doneCurrentSet;
      }
    }

    RealisedExercise doneExo = state.currentExo!.copyWith(sets: doneSets);
    List<RealisedExercise> doneExos = [...state.realisedTraining.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    return doneExos;
  }

  InWorkoutState _mapTimerTickEventToState(TimerTickEvent event) {
    if (state.getNonTickingViews().contains(state.currentView)) {
      return state;
    }
    if (state.realisedTraining.exercises.isEmpty) {
      return state;
    }
    return state.copyWith(elapsedTime: (state.elapsedTime + 1));
  }

  InWorkoutState _mapAddedRepEventToState(AddedRepEvent event) {
    return state.copyWith(reallyDoneReps: state.reallyDoneReps + 1);
  }

  InWorkoutState _mapRemoveRepEventToState(RemovedRepEvent event) {
    if (state.reallyDoneReps == 0) {
      return state;
    }
    return state.copyWith(reallyDoneReps: state.reallyDoneReps - 1);
  }

  InWorkoutState _mapChangedRefWeightEventToState(ChangedRefWeightEvent event) {
    List<RealisedExercise> doneExos =
        updateSet(weight: event.weight, updateNextSets: event.isForAll);
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(exercises: doneExos));
  }

  InWorkoutState _mapChangedRefRepsEventToState(ChangedRefRepsEvent event) {
    List<RealisedExercise> doneExos =
        updateSet(doneReps: event.reps, updateNextSets: event.isForAll);

    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(exercises: doneExos));
  }

  InWorkoutState _mapChangedViewEventToState(ChangedViewEvent event) {
    switch (event.view) {
      case InWorkoutView.endWorkoutView:
        event.tabController.index = 0;
        break;
      case InWorkoutView.inExerciseView:
        event.tabController.index = 0;
        break;
      case InWorkoutView.inRestView:
        event.tabController.index = 1;
        break;
      default:
        break;
    }
    return state.copyWith(currentView: event.view);
  }

  InWorkoutState _mapChangedNbSetEventToState(ChangedNbSetEvent event) {
    List<RealisedExercise> doneExos = updateSet(nbWantedSets: event.nbSets);
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(exercises: doneExos));
  }
}
