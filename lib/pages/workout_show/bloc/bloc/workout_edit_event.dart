part of 'workout_edit_bloc.dart';

abstract class WorkoutEditEvent extends Equatable {}

class SwitchedExerciseEvent extends WorkoutEditEvent {
  final int cycleIndex;
  final int firstIndex;
  final int secondIndex;

  SwitchedExerciseEvent(
      {required this.firstIndex,
      required this.secondIndex,
      this.cycleIndex = 0});

  @override
  List<Object> get props => [firstIndex, secondIndex, cycleIndex];
}

class ToggledEditModeEvent extends WorkoutEditEvent {
  @override
  List<Object?> get props => [];
}

class ChangedExerciseEvent extends WorkoutEditEvent {
  final ReferenceExercise exo;
  final int cycleIndex;
  final int exoIndex;

  ChangedExerciseEvent({
    required this.exo,
    this.cycleIndex = 0,
    required this.exoIndex,
  });

  @override
  List<Object?> get props => [exo, cycleIndex, exoIndex];
}

class RemovedExerciseEvent extends WorkoutEditEvent {
  final int cycleIndex;
  final int exoIndex;

  RemovedExerciseEvent({required this.exoIndex, this.cycleIndex = 0});

  @override
  List<Object?> get props => [exoIndex, cycleIndex];
}
