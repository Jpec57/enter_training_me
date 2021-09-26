import 'package:flutter/material.dart';
import 'dart:math';

class CountdownPainter extends CustomPainter {
  final double radius;
  final int elapsedSeconds;
  final int totalSeconds;
  final double kCountdownStrokeWidth;
  final Color kCountdownDivisionStrokeColor;
  final Color kCountdownProgressStrokeColor;
  final double kCountdownProgressStrokeWidth;

  CountdownPainter({this.elapsedSeconds = 23, this.totalSeconds = 60, this.radius = 100.0,
    this.kCountdownStrokeWidth = 2.0,
    this.kCountdownProgressStrokeWidth = 10.0,
    this.kCountdownDivisionStrokeColor = Colors.black87,
    this.kCountdownProgressStrokeColor = Colors.green,
  });

  Offset _angleToPoint(double radius, double angle) {
    return Offset(
      radius * cos(pi * angle / 180),
      radius * sin(pi * angle / 180),
    );
  }

  void _drawDivisions(Canvas canvas, Size size, double radius) {
    final paint = Paint()..color = kCountdownDivisionStrokeColor;

    final divisionDegrees = 360.0 / totalSeconds;

    for (var i = 0; i < totalSeconds; i++) {
      final offsetAngle = _angleToPoint(radius, divisionDegrees * i - 90.0);

      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.drawCircle(offsetAngle, 2, paint);
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
    canvas.drawArc(rect, -pi / 2, progressAngle, false, innerCirclePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radiusWithoutStrokeWith = radius - kCountdownStrokeWidth;
    final offsetCenter = Offset(
      size.width / 2,
      size.height / 2,
    );
    final rect = Rect.fromCircle(center: offsetCenter,
        radius: radiusWithoutStrokeWith
    );

    _drawDivisions(canvas, size, radiusWithoutStrokeWith);

    _drawProgress(canvas, rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}