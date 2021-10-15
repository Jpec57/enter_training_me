import 'package:charts_flutter/flutter.dart' as charts;

class ExerciseIntensitySerie {
  final String exerciseName;
  final double intensity;
  final charts.Color barColor;

  ExerciseIntensitySerie({required this.exerciseName, required this.intensity, this.barColor = charts.Color.white });
}
