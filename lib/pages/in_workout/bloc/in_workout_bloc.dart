import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

part 'in_workout_event.dart';
part 'in_workout_state.dart';

class InWorkoutBloc extends Bloc<InWorkoutEvent, InWorkoutState> {
  final TrainingRepository trainingRepository;

  InWorkoutBloc(this.trainingRepository, Training referenceTraining,
      Training realisedTraining)
      : super(InWorkoutState(
            referenceTraining: referenceTraining,
            realisedTraining: realisedTraining));

  Future _speak(FlutterTts flutterTts, String text) async {
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop(FlutterTts flutterTts) async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  Stream<InWorkoutState> mapEventToState(
    InWorkoutEvent event,
  ) async* {
    if (event is ExerciseDoneEvent) {
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
      print(doneCycles);
      if (state.isEndOfWorkout) {
        try {
          await trainingRepository
              .postUserTraining(state.realisedTraining.toJson());
        } on Exception catch (e) {
          Get.snackbar("Error", e.toString());
          //TODO Save in local storage to resend later
        }
        yield state.copyWith(isEnd: true);
      }
      yield state.copyWith(
          isEnd: state.isEndOfWorkout,
          currentSetIndex: state.nextSetIndex,
          currentExoIndex: state.nextExoIndex,
          realisedTraining:
              state.realisedTraining.copyWith(cycles: doneCycles));

      // yield _mapRestDoneEventToState(event);
    } else if (event is TimerTickEvent) {
      yield _mapTimerTickEventToState(event);
    } else if (event is AddedRepEvent) {
      yield _mapAddedRepEventToState(event);
    } else if (event is RemovedRepEvent) {
      yield _mapRemoveRepEventToState(event);
    } else if (event is ChangedWeightEvent) {
      yield _mapChangedWeightEventToState(event);
    } else if (event is TrainingEndedEvent) {
      try {
        await trainingRepository
            .postUserTraining(state.realisedTraining.toJson());
      } on Exception catch (e) {
        Get.snackbar("Error", e.toString());
        //TODO Save in local storage to resend later
      }
      yield _mapTrainingEndedEventToState(event);
    } else if (event is TrainingLeftEvent) {
      //Erase all sets above the current one and save training with query
      Get.offNamedUntil(HomePage.routeName, (route) => false);
      yield _mapTrainingLeftEventToState(event);
    }
  }

  InWorkoutState _mapExerciseDoneEventToState(ExerciseDoneEvent event) {
    return state.copyWith(reallyDoneReps: state.currentSet.reps);
  }

  List<ExerciseCycle> updateSet({int? doneReps}) {
    ExerciseSet doneCurrentSet = state.currentSet.copyWith(reps: doneReps);

    List<ExerciseSet> doneSets = [...state.currentExo.sets];
    doneSets[state.currentSetIndex] = doneCurrentSet;

    RealisedExercise doneExo = state.currentExo.copyWith(sets: doneSets);
    List<RealisedExercise> doneExos = [...state.currentCycle.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    ExerciseCycle doneCycle = state.currentCycle.copyWith(exercises: doneExos);
    List<ExerciseCycle> doneCycles = [...state.realisedTraining.cycles];
    doneCycles[state.currentCycleIndex] = doneCycle;
    return doneCycles;
  }

  InWorkoutState _mapRestDoneEventToState(RestDoneEvent event) {
    List<ExerciseCycle> doneCycles = updateSet(doneReps: state.reallyDoneReps);
    print(doneCycles);

    return state.copyWith(
        isEnd: state.isEndOfWorkout,
        currentSetIndex: state.nextSetIndex,
        currentExoIndex: state.nextExoIndex,
        realisedTraining: state.realisedTraining.copyWith(cycles: doneCycles));
  }

  InWorkoutState _mapTrainingLeftEventToState(TrainingLeftEvent event) {
    return state;
  }

  InWorkoutState _mapTrainingEndedEventToState(TrainingEndedEvent event) {
    return state.copyWith(isEnd: true);
  }

  InWorkoutState _mapTimerTickEventToState(TimerTickEvent event) {
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

  InWorkoutState _mapChangedWeightEventToState(ChangedWeightEvent event) {
    return state;
  }
}
