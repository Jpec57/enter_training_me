part of 'in_workout_bloc.dart';

abstract class InWorkoutEvent extends Equatable {
  const InWorkoutEvent();
}

class UpdatedProgressEvent extends InWorkoutEvent {

  @override
  List<Object?> get props => [];
}

class ExerciseDoneEvent extends InWorkoutEvent {
  
  @override
  List<Object?> get props => [];
}