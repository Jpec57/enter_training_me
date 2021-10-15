
import 'package:flutter/material.dart';

class ExerciseIntensitySerie {
  final String exerciseName;
  final double intensity;
    final Color barColor;


  ExerciseIntensitySerie({required this.exerciseName, required this.intensity, this.barColor = Colors.white });
}
