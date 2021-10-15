import 'package:charts_flutter/flutter.dart' as charts;

class WorkoutIntensityOverTimeSerie {
  final int timestamp;
  final double intensity;
  final charts.Color barColor;

  WorkoutIntensityOverTimeSerie(
      {required this.timestamp,
      required this.intensity,
      this.barColor = charts.Color.white});
}
