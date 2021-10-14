import 'package:charts_flutter/flutter.dart' as charts;
import 'package:enter_training_me/widgets/analysis/series/workout_intensity_over_time.dart';
import 'package:flutter/material.dart';

class TrainingHistoryEvolution extends StatelessWidget {
  final List<charts.Series<WorkoutIntensityOverTime, int>> seriesList;
  final bool animate;

  const TrainingHistoryEvolution(
      {Key? key, required this.seriesList, this.animate = false})
      : super(key: key);

  /// Creates a [LineChart] with sample data and no transition.
  factory TrainingHistoryEvolution.withSampleData() {
    return TrainingHistoryEvolution(
      seriesList: _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList,
        defaultRenderer:
            charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<WorkoutIntensityOverTime, int>>
      _createSampleData() {
    final myFakeDesktopData = [
      WorkoutIntensityOverTime(timestamp: 0, intensity: 60),
      WorkoutIntensityOverTime(timestamp: 1, intensity: 40),
      WorkoutIntensityOverTime(timestamp: 2, intensity: 30),
      WorkoutIntensityOverTime(timestamp: 3, intensity: 40),
      WorkoutIntensityOverTime(timestamp: 4, intensity: 90),
      WorkoutIntensityOverTime(timestamp: 5, intensity: 60),
      WorkoutIntensityOverTime(timestamp: 10, intensity: 60),
      WorkoutIntensityOverTime(timestamp: 11, intensity: 40),
      WorkoutIntensityOverTime(timestamp: 12, intensity: 30),
      WorkoutIntensityOverTime(timestamp: 13, intensity: 40),
      WorkoutIntensityOverTime(timestamp: 14, intensity: 90),
      WorkoutIntensityOverTime(timestamp: 15, intensity: 60),
    ];

    final referenceIntensities = [
      WorkoutIntensityOverTime(timestamp: 0, intensity: 20),
      WorkoutIntensityOverTime(timestamp: 1, intensity: 60),
      WorkoutIntensityOverTime(timestamp: 2, intensity: 20),
      WorkoutIntensityOverTime(timestamp: 3, intensity: 40),
      WorkoutIntensityOverTime(timestamp: 4, intensity: 20),
      WorkoutIntensityOverTime(timestamp: 5, intensity: 60),
    ];

    return [
      charts.Series<WorkoutIntensityOverTime, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (WorkoutIntensityOverTime sales, _) => sales.timestamp,
        measureFn: (WorkoutIntensityOverTime sales, _) => sales.intensity,
        data: myFakeDesktopData,
      ),
      charts.Series<WorkoutIntensityOverTime, int>(
        id: 'Desktop Ref',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (WorkoutIntensityOverTime sales, _) => sales.timestamp,
        measureFn: (WorkoutIntensityOverTime sales, _) => sales.intensity,
        data: referenceIntensities,
      ),
    ];
  }
}
