import 'dart:async';
import 'package:ctraining/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final double size;
  final int totalDuration;
  const CountdownTimer({Key? key, required this.totalDuration, this.size = 200.0}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {

  late Timer _timer;
  int _elapsedTime = 0;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsedTime = timer.tick;
        if (timer.tick >= widget.totalDuration) timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        painter: CountdownPainter(
            radius: widget.size / 2,
            elapsedSeconds: _elapsedTime,
            totalSeconds: widget.totalDuration,
          progressStrokeColor: Colors.black,
          divisionStrokeColor: Colors.white
        ),
      ),
    );
  }
}
