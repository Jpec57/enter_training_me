import 'dart:math';

import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';

class InWorkoutRestView extends StatefulWidget {
  const InWorkoutRestView({Key? key}) : super(key: key);

  @override
  _InWorkoutRestViewState createState() => _InWorkoutRestViewState();
}

class _InWorkoutRestViewState extends State<InWorkoutRestView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: CountdownTimer(
              elapsedTime: 0,
              totalDuration: 60,
              progressStrokeColor: CustomTheme.middleGreen,
              size: min(MediaQuery.of(context).size.height * 0.5, MediaQuery.of(context).size.width * 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
