import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class ChronologicalArrowSegmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomTheme.middleGreen
      ..strokeWidth = 2;

    canvas.drawLine(Offset(0, size.height * 0.5),
        Offset(size.width, size.height * 0.5), paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
