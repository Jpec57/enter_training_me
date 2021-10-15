import 'package:enter_training_me/models/realised_exercise.dart';

class ExerciseComparisionDTO {
  final int index;
  final RealisedExercise realisedExercise;
  final RealisedExercise? referenceExercise;

  const ExerciseComparisionDTO(
      {required this.index,  required this.realisedExercise, this.referenceExercise});
}
