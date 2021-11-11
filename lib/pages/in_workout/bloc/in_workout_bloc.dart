import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/community/community_page.dart';
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
    if (event is AddedExoEvent) {
      yield _mapAddedExoEventToState(event);
      yield _mapChangedViewEventToState(
          ChangedViewEvent(event.tabController, InWorkoutView.inExerciseView));
      // if (state.realisedTraining.exercises.isEmpty) {
      //   yield _mapChangedViewEventToState(ChangedViewEvent(
      //       event.tabController, InWorkoutView.endWorkoutView));
      // } else {
      //   yield _mapChangedViewEventToState(
      //       ChangedViewEvent(event.tabController, InWorkoutView.inRestView));
      // }
    } else if (event is ChangedNbLoopsEvent) {
      if (event.nbLoops > 0) {
        yield state.copyWith(
            realisedTraining:
                state.realisedTraining.copyWith(numberOfLoops: event.nbLoops));
      }
    } else if (event is ChangedTrainingNameEvent) {
      Map<String, dynamic> nameData = {"name": event.name};
      if (state.realisedTrainingId != null) {
        try {
          Training? training = await trainingRepository.patch(
              state.realisedTrainingId!, nameData);
          if (training != null) {
            yield state.copyWith(
                realisedTraining:
                    state.realisedTraining.copyWith(name: event.name));
          }
        } on DioError catch (e) {
          Get.snackbar("Error", e.toString());
        }
      } else {
        yield state.copyWith(
            realisedTraining:
                state.realisedTraining.copyWith(name: event.name));
      }

      yield state;
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
        yield state.copyWith(isEnd: true, realisedTrainingId: training?.id);
      }
      yield state.copyWith(
          isEnd: state.isEndOfWorkout,
          currentCycleIndex: state.nextCycleIndex,
          currentSetIndex: state.nextSetIndex,
          currentExoIndex: state.nextExoIndex,
          currentView: InWorkoutView.inExerciseView,
          realisedTraining:
              state.realisedTraining.copyWith(exercises: doneExos));
    } else if (event is ChangedNbSetEvent) {
      yield _mapChangedNbSetEventToState(event);
    } else if (event is ChangedRestBetweenLoopsEvent) {
      yield state.copyWith(
          realisedTraining: state.realisedTraining.copyWith(
              restBetweenCycles: event.seconds > 0 ? event.seconds : 5));
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
    } else if (event is ResetRepEvent) {
      yield state.copyWith(reallyDoneReps: 0);
    } else if (event is TrainingEndedEvent) {
      Training? training = await saveTraining();
      yield state.copyWith(realisedTrainingId: training?.id);
      yield _mapTrainingEndedEventToState(event);
    } else if (event is TrainingLeftEvent) {
      //Erase all sets above the current one and save training with query
      Get.offNamedUntil(
          CommunityPage.routeName, ModalRoute.withName(HomePage.routeName));
      yield _mapTrainingLeftEventToState(event);
    }
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

  InWorkoutState _mapExerciseDoneEventToState(ExerciseDoneEvent event) {
    return state.copyWith(
        reallyDoneReps: state.currentExo!.isIsometric
            ? (state.reallyDoneReps)
            : state.currentSet.reps,
        currentView: InWorkoutView.inRestView);
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

  InWorkoutState _mapChangedExoEventToState(ChangedExoEvent event) {
    RealisedExercise doneExo =
        state.currentExo!.copyWith(exerciseReference: event.exo);
    List<RealisedExercise> doneExos = [...state.realisedTraining.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(exercises: doneExos));
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

  InWorkoutState _mapAddedExoEventToState(AddedExoEvent event) {
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

    return state.copyWith(
        realisedTraining: currentTraining,
        currentExoIndex: nextExoIndex,
        currentSetIndex: 0);
  }

  InWorkoutState _mapChangedNbSetEventToState(ChangedNbSetEvent event) {
    List<RealisedExercise> doneExos = updateSet(nbWantedSets: event.nbSets);
    return state.copyWith(
        realisedTraining: state.realisedTraining.copyWith(exercises: doneExos));
  }
}
