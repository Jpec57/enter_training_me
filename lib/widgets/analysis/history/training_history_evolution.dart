import 'package:charts_flutter/flutter.dart' as charts;
import 'package:enter_training_me/widgets/analysis/series/workout_intensity_over_time_serie.dart';
import 'package:flutter/material.dart';

class TrainingHistoryEvolution extends StatelessWidget {
  final List<charts.Series<WorkoutIntensityOverTimeSerie, int>> seriesList;
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
    return charts.LineChart(
      seriesList,
      defaultRenderer:
          charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: animate,
      primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, color: charts.MaterialPalette.white),
      )),
      domainAxis: const charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, color: charts.MaterialPalette.white),
      )),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<WorkoutIntensityOverTimeSerie, int>>
      _createSampleData() {
    final myFakeDesktopData = [
      WorkoutIntensityOverTimeSerie(timestamp: 0, intensity: 60),
      WorkoutIntensityOverTimeSerie(timestamp: 1, intensity: 40),
      WorkoutIntensityOverTimeSerie(timestamp: 2, intensity: 30),
      WorkoutIntensityOverTimeSerie(timestamp: 3, intensity: 40),
      WorkoutIntensityOverTimeSerie(timestamp: 4, intensity: 90),
      WorkoutIntensityOverTimeSerie(timestamp: 5, intensity: 60),
      WorkoutIntensityOverTimeSerie(timestamp: 10, intensity: 60),
      WorkoutIntensityOverTimeSerie(timestamp: 11, intensity: 40),
      WorkoutIntensityOverTimeSerie(timestamp: 12, intensity: 30),
      WorkoutIntensityOverTimeSerie(timestamp: 13, intensity: 40),
      WorkoutIntensityOverTimeSerie(timestamp: 14, intensity: 90),
      WorkoutIntensityOverTimeSerie(timestamp: 15, intensity: 60),
    ];

    final referenceIntensities = [
      WorkoutIntensityOverTimeSerie(timestamp: 0, intensity: 20),
      WorkoutIntensityOverTimeSerie(timestamp: 1, intensity: 60),
      WorkoutIntensityOverTimeSerie(timestamp: 2, intensity: 20),
      WorkoutIntensityOverTimeSerie(timestamp: 3, intensity: 40),
      WorkoutIntensityOverTimeSerie(timestamp: 4, intensity: 20),
      WorkoutIntensityOverTimeSerie(timestamp: 5, intensity: 60),
    ];

    return [
      charts.Series<WorkoutIntensityOverTimeSerie, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (WorkoutIntensityOverTimeSerie sales, _) => sales.timestamp,
        measureFn: (WorkoutIntensityOverTimeSerie sales, _) => sales.intensity,
        data: myFakeDesktopData,
      ),
      charts.Series<WorkoutIntensityOverTimeSerie, int>(
        id: 'Desktop Ref',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (WorkoutIntensityOverTimeSerie sales, _) => sales.timestamp,
        measureFn: (WorkoutIntensityOverTimeSerie sales, _) => sales.intensity,
        data: referenceIntensities,
      ),
    ];
  }
}
