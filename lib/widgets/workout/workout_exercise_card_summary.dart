import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_set_tile.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseCardSummary extends StatelessWidget {
  final int? index;
  final RealisedExercise realisedExercise;
  final RealisedExercise? expectedRealisedExercise;
  const WorkoutExerciseCardSummary(
      {Key? key,
      required this.realisedExercise,
      this.index = 0,
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
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10))),
                // child: Image.asset(
                // "assets/exercises/pull_up.png",
                // height: 50,
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Text("E$index",
                      style: Theme.of(context).textTheme.headline4),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(realisedExercise.exerciseReference.name,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline4),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: realisedExercise.sets.length,
                  itemBuilder: (context, index) {
                    ExerciseSet? expectedSet =
                        expectedRealisedExercise?.sets[index];
                    ExerciseSet set = realisedExercise.sets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${set.reps} reps ".toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            "${set.weight}kg ",
                          ),
                          _renderSetComparison(set, expectedSet)
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderSetComparison(ExerciseSet set, ExerciseSet? expectedSet) {
    if (expectedSet == null) {
      return Container();
    }
    int differenceReps = set.reps - (expectedSet.reps);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$differenceReps",
              style: TextStyle(
                color: differenceReps >= 0 ? Colors.green : Colors.red,
              )),
          Icon(
              differenceReps >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: differenceReps >= 0 ? Colors.green : Colors.red),
        ],
      ),
    );
  }
}
