import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_set_tile.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseCardSummary extends StatelessWidget {
  final RealisedExercise realisedExercise;
  final ReferenceExercise? referenceExercise;
  final RealisedExercise? expectedRealisedExercise;
  const WorkoutExerciseCardSummary(
      {Key? key,
      required this.realisedExercise,
      required this.referenceExercise,
      this.expectedRealisedExercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomTheme.middleGreen,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/exercises/pull_up.png",
                height: 50,
              ),
              Text(realisedExercise.exerciseReference.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(color: Colors.white70, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realisedExercise.sets.length,
                    itemBuilder: (context, index) {
                      ExerciseSet? expectedSet =
                          expectedRealisedExercise?.sets[index];
                      ExerciseSet set = realisedExercise.sets[index];
                      return Row(
                        children: [
                          Text(
                            "${set.reps} reps ",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "${set.weight}kg ",
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
