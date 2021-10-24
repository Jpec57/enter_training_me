import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CountdownTimer extends StatefulWidget {
  final double? size;
  final int totalDuration;
  final Color? progressStrokeColor;
  final Color? divisionStrokeColor;
  final Color? backgroundColor;
  final VoidCallback onEndCallback;
  final bool isIncludingStop;
  final List<int> bipSeconds;
  const CountdownTimer(
      {Key? key,
      required this.totalDuration,
      this.size,
      this.progressStrokeColor,
      this.backgroundColor = Colors.white,
      this.divisionStrokeColor,
      this.isIncludingStop = false,
      this.bipSeconds = const [10, 3, 2, 1],
      required this.onEndCallback})
      : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  Timer? _timer;
  int _elapsedTime = 0;

  @override
  void initState() {
    if (widget.totalDuration > 0) {
      initTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void resetTimer() {
    _elapsedTime = 0;
    _timer?.cancel();
  }

  Future<AudioPlayer> playLocalAsset({bool isEnd = false}) async {
    AudioCache cache = AudioCache();
    if (isEnd) {
      return await cache.play("sounds/beep_end.mp3");
    }
    return await cache.play("sounds/beep_start.mp3");
  }

  void initTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        _elapsedTime += 1;
      });
      int remainingSeconds = widget.totalDuration - _elapsedTime;
      if (widget.bipSeconds.contains(remainingSeconds)) {
        playLocalAsset();
      }
      if (_elapsedTime >= widget.totalDuration) {
        playLocalAsset(isEnd: true);
        bool? hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator != null && hasVibrator) {
          Vibration.vibrate();
        }
        timer.cancel();
        widget.onEndCallback();
      }
    });
  }

  Widget _renderStack(double size) {
    // Prevent stack from expanding
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: CustomPaint(
              painter: CountdownPainter(
                  radius: size / 2,
                  elapsedSeconds: _elapsedTime,
                  totalSeconds: widget.totalDuration,
                  progressStrokeColor:
                      widget.progressStrokeColor ?? Colors.black,
                  divisionStrokeColor:
                      widget.divisionStrokeColor ?? Colors.white),
            ),
          ),
          widget.isIncludingStop
              ? Positioned(
                  bottom: size / 4 - size / 20,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: widget.onEndCallback,
                    child: Container(
                      padding: EdgeInsets.all(size / 30),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.progressStrokeColor),
                      child: Center(
                        child: Container(
                            height: size / 20,
                            width: size / 20,
                            color: widget.backgroundColor),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return _renderStack(
          widget.size ?? min(constraints.maxWidth, constraints.maxHeight) - 20);
    });
  }
}
