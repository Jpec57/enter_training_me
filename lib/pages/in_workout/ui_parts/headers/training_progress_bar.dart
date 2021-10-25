import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:flutter/material.dart';

class TrainingProgressBar extends StatelessWidget {
  final void Function()? onPressed;
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final List<RealisedExercise>? workoutExercises;

  const TrainingProgressBar(
      {Key? key,
      this.onPressed,
      required this.progress,
      this.workoutExercises,
      this.backgroundColor = CustomTheme.green,
      this.progressColor = CustomTheme.middleGreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (workoutExercises != null) {}
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                      flex: (progress * 100).toInt(),
                      child: Container(
                        color: progressColor,
                      )),
                  Expanded(
                      flex: ((1 - progress) * 100).toInt(), child: Container()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "${(progress * 100).toInt()}%",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
