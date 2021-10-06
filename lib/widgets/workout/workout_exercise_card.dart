import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_set_tile.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final RealisedExercise realisedExercise;
  final RealisedExercise? expectedRealisedExercise;
  const WorkoutExerciseCard(
      {Key? key, required this.realisedExercise, this.expectedRealisedExercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomTheme.middleGreen,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(realisedExercise.exerciseReference.name,
              style: Theme.of(context).textTheme.headline2),
          Image.asset(
            "assets/exercises/pull_up.png",
            height: 100,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Sets",
                      style: Theme.of(context).textTheme.headline4),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realisedExercise.sets.length,
                    itemBuilder: (context, index) {
                      ExerciseSet? expectedSet =
                          expectedRealisedExercise?.sets[index];
                      ExerciseSet set = realisedExercise.sets[index];
                      return WorkoutExerciseSetTile(
                          expectedSet: expectedSet, set: set);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
