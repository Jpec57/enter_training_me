part of 'workout_edit_bloc.dart';

abstract class WorkoutEditEvent extends Equatable {
  const WorkoutEditEvent();

  @override
  List<Object> get props => [];
}

class SwitchedExerciseEvent extends WorkoutEditEvent {

}



class RemovedExerciseEvent extends WorkoutEditEvent {
  
}