import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/reference_exercise.dart';
import 'package:enter_training_me/widgets/lists/reference_exercise_list.dart';
import 'package:flutter/material.dart';


class ChooseExerciseDialog extends StatelessWidget {
  final OnExerciseChosen onExerciseChosen;
  const ChooseExerciseDialog({Key? key, required this.onExerciseChosen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomTheme.darkGrey,
      insetPadding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Center(
                    child: Text(
                      "Choose an exercise",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReferenceExerciseList(
              withSearch: true,
              onExerciseChosen: onExerciseChosen,
            ),
          ),
        ],
      ),
    );
  }
}
