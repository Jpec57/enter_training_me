import 'package:flutter/material.dart';

class WavyLoginTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint1 = Offset(size.width * 0.15, size.height * 0.45);
    var controlPoint2 = Offset(size.width * 0.05, size.height * 0.4);
    var endPoint = Offset(size.width * 0.8, size.height * 0.30);

    Path path = Path();
    path.lineTo(0, size.height * 1);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    path.cubicTo(size.width * 0.90, size.height * 0.20, size.width * 0.95,
        size.height * 0.1, size.width * 1, size.height * 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
