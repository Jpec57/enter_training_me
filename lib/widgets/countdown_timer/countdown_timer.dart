import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_paint.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final double size;
  final int totalDuration;
  final Color? progressStrokeColor;
  final Color? divisionStrokeColor;
  final VoidCallback onEndCallback;
  final bool isIncludingStop;
  final List<int> bipSeconds;
  const CountdownTimer(
      {Key? key,
      required this.totalDuration,
      this.size = 200.0,
      this.progressStrokeColor,
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += 1;
      });
      int remainingSeconds = widget.totalDuration - _elapsedTime;
      if (widget.bipSeconds.contains(remainingSeconds)) {
        playLocalAsset();
      }
      if (_elapsedTime == widget.totalDuration) {
        playLocalAsset(isEnd: true);
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
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: CustomPaint(
                painter: CountdownPainter(
                    radius: widget.size / 2,
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
                    bottom: widget.size / 4 - 25,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomTheme.middleGreen),
                      child: IconButton(
                        icon: const Icon(
                          Icons.stop,
                          color: CustomTheme.darkGrey,
                        ),
                        onPressed: widget.onEndCallback,
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
