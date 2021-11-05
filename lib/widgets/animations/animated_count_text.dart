import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCountText extends StatefulWidget {
  final double count;
  final bool reanimateOnVisibile;
  final Key visibleKey;
  const AnimatedCountText({
    Key? key,
    required this.count,
    required this.visibleKey,
    this.reanimateOnVisibile = false,
  }) : super(key: key);

  @override
  _AnimatedCountTextState createState() => _AnimatedCountTextState();
}

class _AnimatedCountTextState extends State<AnimatedCountText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousVisibilityFraction = 0;
  bool hasBeenAnimatedOnce = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        lowerBound: 0,
        upperBound: widget.count);
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return VisibilityDetector(
          key: widget.visibleKey,
          onVisibilityChanged: (visibilityInfo) {
            double visibleFraction = visibilityInfo.visibleFraction;
            if (visibleFraction > 0 &&
                _previousVisibilityFraction <= 0 &&
                (!hasBeenAnimatedOnce || widget.reanimateOnVisibile)) {
              _relaunchAnimation();
            }
            _previousVisibilityFraction = visibleFraction;
          },
          child: Text(
            _animation.value.toStringAsFixed(1),
          ),
        );
      },
    );
  }
}
