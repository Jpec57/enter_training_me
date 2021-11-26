import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class ChronologicalFirstArrowPainter extends CustomPainter {
  final bool isSelected;
  final Color selectedCircleColor;
  final Color color;

  ChronologicalFirstArrowPainter(
      {required this.selectedCircleColor,
      this.color = CustomTheme.middleGreen,
      required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    const arrowXOffsetFromSegment = 0.15;
    const arrowYOffsetFromSegment = 0.35;

    final lastPointOffset = Offset(size.width, size.height * 0.5);

    canvas.drawLine(Offset(0, size.height * 0.5), lastPointOffset, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 5, paint);

    canvas.drawLine(
        Offset((1 - arrowXOffsetFromSegment) * size.width,
            size.height * (0.5 - arrowYOffsetFromSegment)),
        lastPointOffset,
        paint);
    canvas.drawLine(
        Offset((1 - arrowXOffsetFromSegment) * size.width,
            size.height * (0.5 + arrowYOffsetFromSegment)),
        lastPointOffset,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
