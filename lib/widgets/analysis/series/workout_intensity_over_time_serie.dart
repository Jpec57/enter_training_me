import 'package:flutter/material.dart';

class WorkoutIntensityOverTimeSerie {
  final int timestamp;
  final double intensity;
  final Color barColor;

  WorkoutIntensityOverTimeSerie(
      {required this.timestamp,
      required this.intensity,
      this.barColor = Colors.white});
}
