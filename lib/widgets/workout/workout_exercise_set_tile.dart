import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseSetTile extends StatelessWidget {
  final ExerciseSet set;
  final ExerciseSet? expectedSet;
  const WorkoutExerciseSetTile({Key? key, required this.set, this.expectedSet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int differenceReps = set.reps - (expectedSet?.reps ?? 0);

    return Card(
      color: CustomTheme.green,
      child: ListTile(
        leading: Text(
          "${set.reps}r",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        title: Text("${set.weight}kgs", style: const TextStyle(fontSize: 14)),
        trailing: expectedSet != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("$differenceReps",
                      style: TextStyle(
                        color: differenceReps >= 0 ? Colors.green : Colors.red,
                      )),
                  Icon(
                      differenceReps >= 0
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: differenceReps >= 0 ? Colors.green : Colors.red),
                ],
              )
            : null,
      ),
    );
  }
}
