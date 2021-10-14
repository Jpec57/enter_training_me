import 'package:charts_flutter/flutter.dart' as charts;

class WorkoutIntensityOverTime {
  final int timestamp;
  final double intensity;
  final charts.Color barColor;

  WorkoutIntensityOverTime(
      {required this.timestamp,
      required this.intensity,
      this.barColor = charts.Color.white});
}
