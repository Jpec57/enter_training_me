part of 'workout_edit_bloc.dart';

class WorkoutEditState extends Equatable {
  final Training training;
  final bool isEditting;

  const WorkoutEditState({this.isEditting = false, required this.training});

  WorkoutEditState copyWith({Training? training, bool? isEditting}) =>
      WorkoutEditState(
        training: training ?? this.training,
        isEditting: isEditting ?? this.isEditting,
      );

  @override
  List<Object> get props => [training, isEditting];
}
