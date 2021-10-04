import 'dart:math';

import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/current_exercise_details.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';

class InWorkoutRestView extends StatefulWidget {
  final VoidCallback onTimerEndCallback;
  const InWorkoutRestView({Key? key, required this.onTimerEndCallback})
      : super(key: key);

  @override
  _InWorkoutRestViewState createState() => _InWorkoutRestViewState();
}

class _InWorkoutRestViewState extends State<InWorkoutRestView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: LayoutBuilder(builder: (context, constraints) {
            double maxSize =
                min(constraints.constrainHeight(), constraints.maxWidth);
            return Center(
              child: CountdownTimer(
                totalDuration: 60,
                isIncludingStop: true,
                onEndCallback: widget.onTimerEndCallback,
                progressStrokeColor: CustomTheme.middleGreen,
                size: 200,
              ),
            );
          }),
        ),
      ],
    );
  }
}
