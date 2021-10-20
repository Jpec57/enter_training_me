import 'package:flutter/material.dart';

class WavyLoginBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // var controlPoint1 = Offset(size.width * 0.18, size.height * 0.35);
    // var controlPoint2 = Offset(size.width * 0.05, size.height * 0.1);
    // var endPoint = Offset(size.width * 0.8, size.height * 0.1);

    // var controlPointBezier = Offset(size.width * 0.95, size.height * 0.1);
    // var endPointBezier = Offset(size.width * 0.96, size.height * 0);

    Path pathBottom = Path();
    pathBottom.lineTo(size.width * 0.1, size.height);
    pathBottom.lineTo(size.width * 1, size.height * 0.8);
    pathBottom.lineTo(size.width, size.height);
    pathBottom.lineTo(size.width * 0.1, size.height);
    pathBottom.close();

    return pathBottom;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
