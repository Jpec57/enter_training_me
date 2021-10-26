part of 'workout_edit_bloc.dart';

class WorkoutEditState extends Equatable {
  final Training training;
  final bool isEditting;

  const WorkoutEditState({this.isEditting = false, required this.training});

  @override
  List<Object> get props => [training, isEditting];
}
