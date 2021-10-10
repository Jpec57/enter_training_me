import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:equatable/equatable.dart';
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

  @override
  Stream<InWorkoutState> mapEventToState(
    InWorkoutEvent event,
  ) async* {
    if (event is ExerciseDoneEvent) {
      yield _mapExerciseDoneEventToState(event);
    } else if (event is RestDoneEvent) {
      yield _mapRestDoneEventToState(event);
    } else if (event is TimerTickEvent) {
      yield _mapTimerTickEventToState(event);
    } else if (event is AddedRepEvent) {
      yield _mapAddedRepEventToState(event);
    } else if (event is RemovedRepEvent) {
      yield _mapRemoveRepEventToState(event);
    } else if (event is ChangedWeightEvent) {
      yield _mapChangedWeightEventToState(event);
    } else if (event is TrainingEndedEvent) {
      yield _mapTrainingEndedEventToState(event);
    } else if (event is TrainingLeftEvent) {
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
    //Erase all sets above the current one and save training with query

    trainingRepository.postUserTraining(state.realisedTraining.toJson());
    Get.offNamedUntil(HomePage.routeName, (route) => false);
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
