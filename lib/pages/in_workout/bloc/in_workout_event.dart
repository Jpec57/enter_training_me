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

class ChangeViewEvent extends InWorkoutEvent {

  @override
  List<Object?> get props => [];
}

class RemovedRepEvent extends InWorkoutEvent {
  
  @override
  List<Object?> get props => [];
}

class AddedRepEvent extends InWorkoutEvent {
  
  @override
  List<Object?> get props => [];
}

class ChangedWeightEvent extends InWorkoutEvent {
  final double weight;

  const ChangedWeightEvent(this.weight);
  
  @override
  List<Object?> get props => [weight];
}