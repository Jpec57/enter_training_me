import 'dart:async';
import 'package:enter_training_me/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final double size;
  final int totalDuration;
  final Color? progressStrokeColor;
  final Color? divisionStrokeColor;
  final Function onEndCallback;
  const CountdownTimer({Key? key, required this.totalDuration, this.size = 200.0, this.progressStrokeColor, this.divisionStrokeColor, required this.onEndCallback}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _elapsedTime = 0;

  void resetTimer(){
    _elapsedTime = 0;
    _timer.cancel();
  }

  void initTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        _elapsedTime += 1;
      });
      if (_elapsedTime == widget.totalDuration){
        timer.cancel();
        widget.onEndCallback();
      }
    });
  }

  @override
  void initState() {
    initTimer();
    super.initState();
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
            progressStrokeColor: widget.progressStrokeColor ?? Colors.black,
            divisionStrokeColor: widget.divisionStrokeColor ?? Colors.white
        ),
      ),
    );
  }
}


