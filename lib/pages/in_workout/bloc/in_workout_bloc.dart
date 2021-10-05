import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:equatable/equatable.dart';

part 'in_workout_event.dart';
part 'in_workout_state.dart';

class InWorkoutBloc extends Bloc<InWorkoutEvent, InWorkoutState> {
  InWorkoutBloc(Training referenceTraining, Training realisedTraining)
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
    }
  }

  InWorkoutState _mapExerciseDoneEventToState(ExerciseDoneEvent event) {
    if (state.isEndOfWorkout){
      return state.copyWith(
        isEnd: true
      );
    }
    return state;
  }

  void updateReallyDoneReps(int doneReps) {}

  InWorkoutState _mapRestDoneEventToState(RestDoneEvent event) {
    Training doneTraining = state.realisedTraining;

    ExerciseSet doneCurrentSet =
        state.currentSet.copyWith(reps: event.doneReps);
    List<ExerciseSet> doneSets = [...state.currentExo.sets];
    doneSets[state.currentSetIndex] = doneCurrentSet;

    RealisedExercise doneExo = state.currentExo.copyWith(sets: doneSets);
    List<RealisedExercise> doneExos = [...state.currentCycle.exercises];
    doneExos[state.currentExoIndex] = doneExo;

    ExerciseCycle doneCycle = state.currentCycle.copyWith(exercises: doneExos);
    List<ExerciseCycle> doneCycles = [...state.realisedTraining.cycles];
    doneCycles[state.currentCycleIndex] = doneCycle;

    return state.copyWith(
        isEnd: state.isEndOfWorkout,
        currentSetIndex: state.nextSetIndex,
        currentExoIndex: state.nextExoIndex,
        realisedTraining: doneTraining.copyWith(cycles: doneCycles));
  }

  InWorkoutState _mapTrainingEndedEventToState(TrainingEndedEvent event) {
    //Erase all sets above the current one
    return state;
  }

  InWorkoutState _mapTimerTickEventToState(TimerTickEvent event) {
    return state.copyWith(elapsedTime: (state.elapsedTime + 1));
  }
}
