import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final num count;

  const AnimatedCount(
      {Key? key,
      required this.count,
      required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  Tween<dynamic>? _count;

  @override
  Widget build(BuildContext context) {
    return widget.count is int
        ? Text(_count!.evaluate(animation).toString())
        : Text(_count!.evaluate(animation).toStringAsFixed(1));
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.count is int) {
      _count = visitor(
        _count,
        widget.count,
        (dynamic value) => IntTween(begin: value),
      );
    } else {
      _count = visitor(
        _count,
        widget.count,
        (dynamic value) => Tween<double>(begin: value),
      );
    }
  }
}
