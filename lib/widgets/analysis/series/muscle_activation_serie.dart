import 'package:flutter/material.dart';

class MuscleActivationSerie {
  final String muscleName;
  final double ratio;
  final Color color;

  const MuscleActivationSerie({required this.muscleName, required this.ratio, this.color = Colors.orange});
}
