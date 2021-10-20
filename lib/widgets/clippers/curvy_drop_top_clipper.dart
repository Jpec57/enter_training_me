import 'package:flutter/material.dart';

class CurvyDropTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double maxHeight = 0.35;
    // double maxHeight = 0.85;
    var controlPoint1 = Offset(size.width * 0.18, size.height * maxHeight);
    var controlPoint2 =
        Offset(size.width * 0.05, size.height * (maxHeight - 0.25));
    var endPoint = Offset(size.width * 0.8, size.height * (maxHeight - 0.25));

    var controlPointBezier =
        Offset(size.width * 0.95, size.height * (maxHeight - 0.25));
    var endPointBezier = Offset(size.width * 0.96, size.height * 0);

    Path path = Path();
    path.lineTo(0, size.height * maxHeight);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    path.quadraticBezierTo(controlPointBezier.dx, controlPointBezier.dy,
        endPointBezier.dx, endPointBezier.dy);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
