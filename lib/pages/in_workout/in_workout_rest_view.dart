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
            // print(constraints.constrainHeight());
            // print(constraints.maxWidth);
            // print(maxSize);
            return Center(
              child: CountdownTimer(
                totalDuration: 60,
                onEndCallback: widget.onTimerEndCallback,
                progressStrokeColor: CustomTheme.middleGreen,
                size: 200,
              ),
            );
          }),
        ),
        // IconButton(onPressed: onPressed, icon: icon)
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: CustomTheme.middleGreen),
          child: IconButton(
            icon: const Icon(
              Icons.stop,
              color: CustomTheme.darkGrey,
            ),
            onPressed: widget.onTimerEndCallback,
          ),
        ),
      ],
    );
  }
}
