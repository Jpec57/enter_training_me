import 'package:enter_training_me/widgets/analysis/series/exercise_intensity.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InWorkoutExerciseIntensity extends StatelessWidget {
  final List<charts.Series<ExerciseIntensity, String>> seriesList;
  final bool animate;

  const InWorkoutExerciseIntensity(this.seriesList,
      {Key? key, this.animate = true})
      : super(key: key);

  /// Creates a [BarChart] with sample data and no transition.
  factory InWorkoutExerciseIntensity.withSampleData() {
    return InWorkoutExerciseIntensity(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ExerciseIntensity, String>> _createSampleData() {
    final data = [
      ExerciseIntensity(exerciseName: "Dips", intensity: 45),
      ExerciseIntensity(exerciseName: "Pull Ups", intensity: 60),
      ExerciseIntensity(exerciseName: "Bench Press", intensity: 35),
      ExerciseIntensity(exerciseName: "Curl", intensity: 15),
      ExerciseIntensity(exerciseName: "Dips", intensity: 45),
      ExerciseIntensity(exerciseName: "Pull Ups", intensity: 60),
      ExerciseIntensity(exerciseName: "Bench Press", intensity: 35),
      ExerciseIntensity(exerciseName: "Curl", intensity: 15),
      ExerciseIntensity(exerciseName: "Dips", intensity: 45),
      ExerciseIntensity(exerciseName: "Pull Ups", intensity: 60),
      ExerciseIntensity(exerciseName: "Bench Press", intensity: 35),
      ExerciseIntensity(exerciseName: "Curl", intensity: 15),
    ];

    return [
      charts.Series<ExerciseIntensity, String>(
          id: 'Workout intensity',
          //Color bar
          seriesColor: charts.Color.white,
          domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
          measureFn: (ExerciseIntensity exo, _) => exo.intensity,
          data: data,
          labelAccessorFn: (datum, index) => "toto")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      defaultInteractions: true,
      // primaryMeasureAxis: const charts.NumericAxisSpec(
      //     renderSpec: charts.GridlineRendererSpec(
      //   labelStyle: charts.TextStyleSpec(
      //       fontSize: 10,
      //       color: charts.MaterialPalette
      //           .white), //chnage white color as per your requirement.
      // )),
      // domainAxis: const charts.AxisSpec(
      //     renderSpec: charts.GridlineRendererSpec(
      //   labelStyle: charts.TextStyleSpec(
      //       fontSize: 10,
      //       color: charts.MaterialPalette
      //           .white), //chnage white color as per your requirement.
      // )),
    );
  }
}
