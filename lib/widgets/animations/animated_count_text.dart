import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef StringWidget = Widget Function(String count);

class AnimatedCountText extends StatefulWidget {
  final num count;
  final num lowerBound;
  final bool reanimateOnVisibile;
  final StringWidget widgetFromStringGenerator;
  final Duration duration;
  const AnimatedCountText({
    Key? key,
    required this.count,
    this.lowerBound = 0.0,
    required this.widgetFromStringGenerator,
    this.duration = const Duration(milliseconds: 1500),
    this.reanimateOnVisibile = false,
  }) : super(key: key);

  @override
  _AnimatedCountTextState createState() => _AnimatedCountTextState();
}

class _AnimatedCountTextState<T> extends State<AnimatedCountText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  double _previousVisibilityFraction = 0;
  bool hasBeenAnimatedOnce = false;
  final Key visibleKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        lowerBound: widget.lowerBound.toDouble(),
        upperBound: widget.count.toDouble());
    _animation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _relaunchAnimation() {
    _controller.forward(from: 0.0);
    hasBeenAnimatedOnce = true;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: visibleKey,
      onVisibilityChanged: (visibilityInfo) {
        double visibleFraction = visibilityInfo.visibleFraction;
        if (visibleFraction > 0 &&
            _previousVisibilityFraction <= 0 &&
            (!hasBeenAnimatedOnce || widget.reanimateOnVisibile)) {
          _relaunchAnimation();
        }
        _previousVisibilityFraction = visibleFraction;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          String value = widget.count is int
              ? (_animation.value).toInt().toString()
              : _animation.value.toStringAsFixed(1);
          return widget.widgetFromStringGenerator(value);
        },
      ),
    );
  }
}
