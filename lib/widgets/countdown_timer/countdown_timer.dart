import 'package:enter_training_me/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final double size;
  final int elapsedTime;
  final int totalDuration;
  final Color? progressStrokeColor;
  final Color? divisionStrokeColor;
  const CountdownTimer({Key? key, required this.totalDuration, this.size = 200.0, this.progressStrokeColor, this.divisionStrokeColor, required this.elapsedTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: CountdownPainter(
            radius: size / 2,
            elapsedSeconds: elapsedTime,
            totalSeconds: totalDuration,
            progressStrokeColor: progressStrokeColor ?? Colors.black,
            divisionStrokeColor: divisionStrokeColor ?? Colors.white
        ),
      ),
    );
  }
}


