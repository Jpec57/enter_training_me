import 'package:ctraining/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CountdownPainter extends CustomPainter {
  final double radius;
  final int elapsedSeconds;
  final int totalSeconds;
  final double divisionPadding;
  final double divisionStrokeWidth;
  final Color divisionStrokeColor;
  final Color progressStrokeColor;
  final double progressStrokeWidth;
  final double fontSizeRatio;

  CountdownPainter({
    this.elapsedSeconds = 23,
    this.totalSeconds = 180,
    this.radius = 100.0,
    this.divisionStrokeWidth = 1,
    this.fontSizeRatio = 0.9,
    this.divisionPadding = 2,
    this.progressStrokeWidth = 10.0,
    this.divisionStrokeColor = Colors.white70,
    this.progressStrokeColor = Colors.green,
  }) : assert(
  progressStrokeWidth - divisionPadding * 2 >= 0 &&
  fontSizeRatio <= 1.0
  );

  Offset _angleToPoint(double radius, double angle) {
    return Offset(
      radius * cos(pi * angle / 180),
      radius * sin(pi * angle / 180),
    );
  }

  void _drawDivisions(Canvas canvas, Size size, double radius) {
    final paint = Paint()
      ..color = divisionStrokeColor
      ..strokeWidth = divisionStrokeWidth
    ;

    final divisionDegrees = 360.0 / totalSeconds;
    for (var i = 0; i < totalSeconds; i++) {
      final innerOffsetAngle = _angleToPoint(radius - progressStrokeWidth + divisionPadding, divisionDegrees * i - 90.0);
      final outerOffsetAngle = _angleToPoint(radius - divisionPadding, divisionDegrees * i - 90.0);

      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.drawLine(innerOffsetAngle, outerOffsetAngle, paint);
      canvas.restore();
    }
  }

  void _drawProgress(Canvas canvas, rect) {
    final innerCirclePaint = Paint()
      ..color = progressStrokeColor
      ..strokeWidth = progressStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
    ;
    final progressAngle = 2 * pi * (elapsedSeconds / totalSeconds);
    double offset = 0;
    canvas.drawArc(rect, -pi / 2 + offset, progressAngle, false, innerCirclePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radiusWithoutStrokeWith = radius - progressStrokeWidth / 2;
    final offsetCenter = Offset(
      size.width / 2,
      size.height / 2,
    );
    final rect = Rect.fromCircle(center: offsetCenter,
        radius: radiusWithoutStrokeWith
    );

    _drawDivisions(canvas, size, radius);
    _drawProgress(canvas, rect);
    _drawCountdownText(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawCountdownText(Canvas canvas, size) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: fontSizeRatio * (radius / 2), fontWeight: FontWeight.w700),
        text: Utils.convertToTime(totalSeconds - elapsedSeconds));
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2- tp.height / 2));
  }
}