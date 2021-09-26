import 'package:ctraining/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final double size = 200.0;
  final int totalDuration;
  const CountdownTimer({Key? key, required this.totalDuration}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int elapsedTime = 23;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: CountdownPainter(
            // radius: widget.size / 2,
            radius: 100,
            elapsedSeconds: elapsedTime,
            totalSeconds: widget.totalDuration,
          progressStrokeColor: Colors.black,
          divisionStrokeColor: Colors.white
        ),
      ),
    );
  }
}
