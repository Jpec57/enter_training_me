import 'dart:async';
import 'package:ctraining/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final double size;
  final int totalDuration;
  final Color? progressStrokeColor;
  final Color? divisionStrokeColor;
  const CountdownTimer({Key? key, required this.totalDuration, this.size = 200.0, this.progressStrokeColor, this.divisionStrokeColor}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {

  late Timer _timer;
  int _elapsedTime = 0;
  late int _realTotalDuration;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _realTotalDuration = widget.totalDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsedTime = timer.tick;
        if (timer.tick >= _realTotalDuration) timer.cancel();
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
            totalSeconds: _realTotalDuration,
            progressStrokeColor: widget.progressStrokeColor ?? Colors.black,
            divisionStrokeColor: widget.divisionStrokeColor ?? Colors.white
        ),
      ),
    );
  }
}
