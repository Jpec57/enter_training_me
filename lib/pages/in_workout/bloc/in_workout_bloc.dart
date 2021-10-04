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
    }
  }

  InWorkoutState _mapExerciseDoneEventToState(ExerciseDoneEvent event) {
    return state;
  }

  InWorkoutState _mapRestDoneEventToState(RestDoneEvent event) {
    Training doneTraining = state.realisedTraining;
    ExerciseSet doneCurrentSet = doneTraining.cycles[state.currentCycleIndex]
        .exercises[state.currentExoIndex].sets[state.currentSetIndex]
        .copyWith(reps: event.doneReps);

    // doneTraining.cycles[state.currentCycleIndex].exercises[state.currentExoIndex].sets = [];

    // doneTraining.cycles[state.currentCycleIndex].exercises[state.currentExoIndex].sets[state.currentSetIndex].reps = event.doneReps;

    return state;
  }

  InWorkoutState _mapTrainingEndedEventToState(TrainingEndedEvent event) {
    //Erase all sets above the current one
    return state;
  }
}
