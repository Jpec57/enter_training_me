import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

part 'in_workout_event.dart';
part 'in_workout_state.dart';

enum InWorkoutView {
  inExerciseView,
  inRestView,
  endWorkoutView,
  newExerciseView
}

class InWorkoutBloc extends Bloc<InWorkoutEvent, InWorkoutState> {
  final TrainingRepository trainingRepository;

  InWorkoutBloc(this.trainingRepository, int? referenceTrainingId,
      Training realisedTraining)
      : super(InWorkoutState(
            referenceTrainingId: referenceTrainingId,
            realisedTraining: realisedTraining));

  Future _speak(FlutterTts flutterTts, String text) async {
    await flutterTts.speak(text);
  }

  @override
  Stream<InWorkoutState> mapEventToState(
    InWorkoutEvent event,
  ) async* {
    if (event is ToggledContentVisibilityEvent) {
      yield state.copyWith(shouldHideContent: event.shouldHideContent);
    } else if (event is AddedExoEvent) {
      yield _mapAddedExoEventToState(event);
      if (state.isAutoPlayOn) {
        yield _mapChangedViewEventToState(ChangedViewEvent(
            event.tabController, InWorkoutView.inExerciseView));
      } else {
        if (state.realisedTraining.exercisesAsFlatList.isEmpty) {
          yield _mapChangedViewEventToState(ChangedViewEvent(
              event.tabController, InWorkoutView.endWorkoutView));
        } else {
          yield _mapChangedViewEventToState(
              ChangedViewEvent(event.tabController, InWorkoutView.inRestView));
        }
      }
    } else if (event is ChangedTrainingNameEvent) {
      Map<String, dynamic> nameData = {"name": event.name};
      if (state.realisedTrainingId != null) {
        try {
          await trainingRepository.patch(state.realisedTrainingId!, nameData);
        } on DioError catch (e) {
          Get.snackbar("Error", e.toString());
        }
      }

      yield state.copyWith(
          realisedTraining: state.realisedTraining.copyWith(name: event.name));
    } else if (event is ChangedViewEvent) {
      yield _mapChangedViewEventToState(event);
    } else if (event is ExerciseDoneEvent) {
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

      yield _mapExerciseDoneEventToState(event);
    } else if (event is RestDoneEvent) {
      List<ExerciseCycle> doneCycles =
          updateSet(doneReps: state.reallyDoneReps);
      if (state.isEndOfWorkout) {
        Training? training = await saveTraining();
        yield state.copyWith(isEnd: true, realisedTrainingId: training?.id);
      }
      yield state.copyWith(
          isEnd: state.isEndOfWorkout,
          currentSetIndex: state.nextSetIndex,
          currentExoIndex: state.nextExoIndex,
          realisedTraining:
              state.realisedTraining.copyWith(cycles: doneCycles));
    } else if (event is ChangedNbSetEvent) {
      yield _mapChangedNbSetEventToState(event);
    } else if (event is ChangedExoEvent) {
      yield _mapChangedExoEventToState(event);
    } else if (event is TimerTickEvent) {
      yield _mapTimerTickEventToState(event);
    } else if (event is AddedRepEvent) {
      yield _mapAddedRepEventToState(event);
    } else if (event is RemovedRepEvent) {
      yield _mapRemoveRepEventToState(event);
    } else if (event is ChangedRefRepsEvent) {
      yield _mapChangedRefRepsEventToState(event);
    } else if (event is ChangedRefWeightEvent) {
      yield _mapChangedRefWeightEventToState(event);
    } else if (event is TrainingEndedEvent) {
      Training? training = await saveTraining();
      yield state.copyWith(realisedTrainingId: training?.id);
      yield _mapTrainingEndedEventToState(event);
    } else if (event is TrainingLeftEvent) {
      //Erase all sets above the current one and save training with query
      Get.offNamedUntil(HomePage.routeName, (route) => false);
      yield _mapTrainingLeftEventToState(event);
    }
  }

  Future<Training?> saveTraining() async {
    Training? training;
    try {
      //TODO save change in referenceTraining with a patch request
      training = await trainingRepository
          .postUserTraining(state.realisedTraining.toJson());
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
      //TODO Save in local storage to resend later
    }
    return training;
  }

  InWorkoutState _mapExerciseDoneEventToState(ExerciseDoneEvent event) {
    return state.copyWith(reallyDoneReps: state.currentSet.reps);
  }

  List<ExerciseCycle> updateSet(
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
    List<RealisedExercise> doneExos = [...state.currentCycle!.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    ExerciseCycle doneCycle = state.currentCycle!.copyWith(exercises: doneExos);
    List<ExerciseCycle> doneCycles = [...state.realisedTraining.cycles];
    doneCycles[state.currentCycleIndex] = doneCycle;
    return doneCycles;
  }

  InWorkoutState _mapTrainingLeftEventToState(TrainingLeftEvent event) {
    return state;
  }

  InWorkoutState _mapTrainingEndedEventToState(TrainingEndedEvent event) {
    return state.copyWith(isEnd: true);
  }

  InWorkoutState _mapTimerTickEventToState(TimerTickEvent event) {
    if (state.getNonTickingViews().contains(state.currentView)) {
      return state;
    }
    if (state.realisedTraining.exercisesAsFlatList.isEmpty) {
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

  InWorkoutState _mapChangedExoEventToState(ChangedExoEvent event) {
    RealisedExercise doneExo =
        state.currentExo!.copyWith(exerciseReference: event.exo);
    List<RealisedExercise> doneExos = [...state.currentCycle!.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    ExerciseCycle doneCycle = state.currentCycle!.copyWith(exercises: doneExos);
    List<ExerciseCycle> doneCycles = [...state.realisedTraining.cycles];
    doneCycles[state.currentCycleIndex] = doneCycle;
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(cycles: doneCycles));
  }

  InWorkoutState _mapChangedRefWeightEventToState(ChangedRefWeightEvent event) {
    List<ExerciseCycle> doneCycles =
        updateSet(weight: event.weight, updateNextSets: event.isForAll);
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(cycles: doneCycles));
  }

  InWorkoutState _mapChangedRefRepsEventToState(ChangedRefRepsEvent event) {
    List<ExerciseCycle> doneCycles =
        updateSet(doneReps: event.reps, updateNextSets: event.isForAll);

    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(cycles: doneCycles));
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

  InWorkoutState _mapAddedExoEventToState(AddedExoEvent event) {
    int nextExoIndex = state.currentExoIndex;
    Training currentTraining = state.realisedTraining;
    if (state.currentCycleIndex >= currentTraining.cycles.length) {
      currentTraining = currentTraining.copyWith(cycles: [
        ...currentTraining.cycles,
        const ExerciseCycle(
            exercises: [], numberOfLoops: 1, restBetweenLoop: 60)
      ]);
    }
    if (currentTraining.cycles[state.currentCycleIndex].exercises.isNotEmpty) {
      List<RealisedExercise> exos = [
        ...currentTraining.cycles[state.currentCycleIndex].exercises
      ];
      exos.insert(state.currentExoIndex + 1, event.exo);
      currentTraining.cycles[state.currentCycleIndex] = currentTraining
          .cycles[state.currentCycleIndex]
          .copyWith(exercises: exos);
      nextExoIndex++;
    } else {
      currentTraining.cycles[state.currentCycleIndex] = currentTraining
          .cycles[state.currentCycleIndex]
          .copyWith(exercises: [event.exo]);
    }
    List<ExerciseCycle> cycles = [
      ...currentTraining.cycles,
    ];
    currentTraining = currentTraining.copyWith(cycles: cycles);
    return state.copyWith(
        realisedTraining: currentTraining,
        currentExoIndex: nextExoIndex,
        currentSetIndex: 0);
  }

  InWorkoutState _mapChangedNbSetEventToState(ChangedNbSetEvent event) {
    List<ExerciseCycle> doneCycles = updateSet(nbWantedSets: event.nbSets);
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(cycles: doneCycles));
  }
}
