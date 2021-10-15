import 'package:carousel_slider/carousel_slider.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_card_summary.dart';
import 'package:flutter/material.dart';

class WorkoutTrainingSummaryContent extends StatelessWidget {
  final Training realisedTraining;
  final Training? referenceTraining;

  const WorkoutTrainingSummaryContent(
      {Key? key, required this.realisedTraining, this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(enlargeCenterPage: true, height: 250),
      items: realisedTraining
          .getExerciseComparisionsList(referenceTraining)
          .map((comp) => WorkoutExerciseCardSummary(
                index: comp.index,
                realisedExercise: comp.realisedExercise,
                expectedRealisedExercise: comp.referenceExercise,
              ))
          .toList(),
    );
  }
}
