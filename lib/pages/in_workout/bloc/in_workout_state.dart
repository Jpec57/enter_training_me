part of 'in_workout_bloc.dart';

class InWorkoutState extends Equatable {
  final Training referenceTraining;
  final Training? realisedTraining;

  const InWorkoutState(
      {required this.referenceTraining, this.realisedTraining});

  @override
  List<Object?> get props => [referenceTraining, realisedTraining];
}
