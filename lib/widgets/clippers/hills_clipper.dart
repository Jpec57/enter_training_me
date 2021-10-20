import 'package:flutter/material.dart';

class HillsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.95);

    path.quadraticBezierTo(size.width * 1 / 8, size.height * 0.85,
        size.width * 0.25, size.height * 0.85);

    path.quadraticBezierTo(size.width * 0.3, size.height * 0.85,
        size.width * 3 / 8 - 5, size.height * 0.9);

    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.99,
      size.width * 0.62,
      size.height * 0.9,
    );

    path.quadraticBezierTo(size.width * 0.75, size.height * 0.80,
        size.width * 0.95, size.height * 0.95);

    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.97, size.width, size.height * 0.99);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
