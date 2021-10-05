part of 'in_workout_bloc.dart';

abstract class InWorkoutEvent extends Equatable {
  const InWorkoutEvent();
}

class RestDoneEvent extends InWorkoutEvent {
  final int doneReps;

  const RestDoneEvent({required this.doneReps});
  // final int restTimeTaken;

  @override
  List<Object?> get props => [doneReps];
}

class ExerciseDoneEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class TrainingEndedEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class TimerTickEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}