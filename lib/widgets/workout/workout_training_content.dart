import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_card.dart';
import 'package:flutter/material.dart';

class WorkoutTrainingContent extends StatelessWidget {
  final Training referenceTraining;
  final Training? trainingToCompareWith;

  const WorkoutTrainingContent(
      {Key? key, required this.referenceTraining, this.trainingToCompareWith})
      : super(key: key);

  Widget _renderExerciseCard(
      {RealisedExercise? expectedRealisedExercise,
      required RealisedExercise realisedExercise}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: WorkoutExerciseCard(
        expectedRealisedExercise: expectedRealisedExercise,
        realisedExercise: realisedExercise,
        referenceExercise: expectedRealisedExercise?.exerciseReference,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> exerciceContainers = [];
    for (var i = 0; i < referenceTraining.exercises.length; i++) {
      exerciceContainers.add(_renderExerciseCard(
          realisedExercise: referenceTraining.exercises[i],
          expectedRealisedExercise: trainingToCompareWith?.exercises[i]));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(children: exerciceContainers),
    );
  }
}
