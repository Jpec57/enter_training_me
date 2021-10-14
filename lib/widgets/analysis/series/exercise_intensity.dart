import 'package:charts_flutter/flutter.dart' as charts;

class ExerciseIntensity {
  final String exerciseName;
  final double intensity;
  final charts.Color barColor;

  ExerciseIntensity({required this.exerciseName, required this.intensity, this.barColor = charts.Color.white });
}
