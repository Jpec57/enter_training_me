part of 'workout_edit_bloc.dart';

class WorkoutEditState extends Equatable {
  final Training training;
  final bool isEditting;
  final bool hasMadeChanges;

  const WorkoutEditState(
      {this.hasMadeChanges = false,
      this.isEditting = false,
      required this.training});

  WorkoutEditState copyWith(
          {Training? training, bool? isEditting, bool? hasMadeChanges}) =>
      WorkoutEditState(
        training: training ?? this.training,
        isEditting: isEditting ?? this.isEditting,
        hasMadeChanges: hasMadeChanges ?? this.hasMadeChanges,
      );

  @override
  List<Object> get props => [training, isEditting, hasMadeChanges];
}
