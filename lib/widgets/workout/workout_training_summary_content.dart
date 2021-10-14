import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_card.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_card_summary.dart';
import 'package:flutter/material.dart';

class WorkoutTrainingSummaryContent extends StatelessWidget {
  final Training referenceTraining;

  const WorkoutTrainingSummaryContent(
      {Key? key, required this.referenceTraining})
      : super(key: key);

  Widget _renderExerciseCard(
      {RealisedExercise? expectedRealisedExercise,
      required RealisedExercise realisedExercise}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: WorkoutExerciseCardSummary(
        expectedRealisedExercise: expectedRealisedExercise,
        realisedExercise: realisedExercise,
        referenceExercise: expectedRealisedExercise?.exerciseReference,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> exerciceContainers = [];

    for (var j = 0; j < referenceTraining.cycles.length; j++) {
      var refCycle = referenceTraining.cycles[j];
      for (var i = 0; i < refCycle.exercises.length; i++) {
        exerciceContainers.add(_renderExerciseCard(
            realisedExercise: refCycle.exercises[i],
            expectedRealisedExercise: null));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: exerciceContainers.length,
          itemBuilder: (context, index) {
            return exerciceContainers[index];
          }),
    );
  }
}
