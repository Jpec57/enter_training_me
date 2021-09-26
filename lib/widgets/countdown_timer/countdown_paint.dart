import 'package:flutter/material.dart';
import 'dart:math';

class CountdownPainter extends CustomPainter {
  final double radius;
  final int elapsedSeconds;
  final int totalSeconds;
  final double kCountdownDivisionStrokeWidth;
  final double kDivisionPadding;
  final Color kCountdownDivisionStrokeColor;
  final Color kCountdownProgressStrokeColor;
  final double kCountdownProgressStrokeWidth;
  // final double kCountdownDivisionStrokeLength;

  CountdownPainter({
    this.elapsedSeconds = 23,
    this.totalSeconds = 180,
    this.radius = 100.0,
    this.kCountdownDivisionStrokeWidth = 0.5,
    this.kDivisionPadding = 2,
    this.kCountdownProgressStrokeWidth = 10.0,
    this.kCountdownDivisionStrokeColor = Colors.white70,
    this.kCountdownProgressStrokeColor = Colors.green,
  }) : assert(kCountdownProgressStrokeWidth - kDivisionPadding * 2 >= 0);

  Offset _angleToPoint(double radius, double angle) {
    return Offset(
      radius * cos(pi * angle / 180),
      radius * sin(pi * angle / 180),
    );
  }

  void _drawDivisions(Canvas canvas, Size size, double radius) {
    final paint = Paint()
      ..color = kCountdownDivisionStrokeColor
      ..strokeWidth = 2
    ;

    final divisionDegrees = 360.0 / totalSeconds;
    for (var i = 0; i < totalSeconds; i++) {
      final innerOffsetAngle = _angleToPoint(radius - kCountdownProgressStrokeWidth + kDivisionPadding, divisionDegrees * i - 90.0);
      final outerOffsetAngle = _angleToPoint(radius - kDivisionPadding, divisionDegrees * i - 90.0);

      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.drawLine(innerOffsetAngle, outerOffsetAngle, paint);
      canvas.restore();
    }
  }

  void _drawProgress(Canvas canvas, rect) {
    final innerCirclePaint = Paint()
      ..color = kCountdownProgressStrokeColor
      ..strokeWidth = kCountdownProgressStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
    ;
    final progressAngle = 2 * pi * (elapsedSeconds / totalSeconds);
    canvas.drawArc(rect, -pi / 2 + 0.05, progressAngle, false, innerCirclePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radiusWithoutStrokeWith = radius - kCountdownProgressStrokeWidth / 2;
    final offsetCenter = Offset(
      size.width / 2,
      size.height / 2,
    );
    final rect = Rect.fromCircle(center: offsetCenter,
        radius: radiusWithoutStrokeWith
    );

    _drawDivisions(canvas, size, radius);
    _drawProgress(canvas, rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}