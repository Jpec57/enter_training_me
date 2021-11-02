import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/lists/reference_exercise_list.dart';
import 'package:flutter/material.dart';

class ReferenceExerciseListTile extends StatelessWidget {
  final ReferenceExercise exo;
  final OnExerciseChosen onExerciseChosen;
  const ReferenceExerciseListTile(
      {Key? key, required this.exo, required this.onExerciseChosen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onExerciseChosen(exo);
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: CustomTheme.middleGreen))),
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "assets/exercises/pull_up.png",
                width: 70,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exo.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          exo.material.isEmpty
                              ? "None"
                              : exo.material.join(', '),
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white54)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:
                          Text(exo.description ?? "No description available."),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
