import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/analysis/series/exercise_intensity.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InWorkoutExerciseIntensity extends StatelessWidget {
  final List<charts.Series<ExerciseIntensity, String>> seriesList;
  final bool animate;

  const InWorkoutExerciseIntensity(this.seriesList,
      {Key? key, this.animate = true})
      : super(key: key);

  factory InWorkoutExerciseIntensity.withSampleData() {
    return InWorkoutExerciseIntensity(
      _createSampleData(),
      animate: false,
    );
  }

  factory InWorkoutExerciseIntensity.fromTraining(
      {required Training realisedTraining, Training? referenceTraining}) {
    List<charts.Series<ExerciseIntensity, String>> data = [];
    List<ExerciseIntensity> realisedData = [];
    List<ExerciseIntensity> referenceData = [];

    for (var i = 0; i < realisedTraining.cycles.length; i++) {
      var exos = realisedTraining.cycles[i].exercises;
      for (var j = 0; j < exos.length; j++) {
        realisedData.add(ExerciseIntensity(
            exerciseName: "${exos[j].exerciseReference.name} ${i}C${j}E",
            intensity: exos[j].intensity));
      }
    }
    if (referenceTraining != null) {
      for (var i = 0; i < referenceTraining.cycles.length; i++) {
        var exos = referenceTraining.cycles[i].exercises;
        for (var j = 0; j < exos.length; j++) {
          referenceData.add(ExerciseIntensity(
              exerciseName: "${exos[j].exerciseReference.name} ${i}C${j}E",
              intensity: exos[j].intensity));
        }
      }
      if (referenceData.isNotEmpty) {
        data.add(
          charts.Series<ExerciseIntensity, String>(
            id: 'Workout Ref intensity',
            displayName: "Reference Workout Intensity",
            //Color bar
            seriesColor: charts.Color.fromHex(code: "#bcbcbc"),
            domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
            measureFn: (ExerciseIntensity exo, _) => exo.intensity,
            data: referenceData,
          ),
        );
      }
    }

    data = [
      charts.Series<ExerciseIntensity, String>(
        id: 'Realised Workout Intensity',
        displayName: 'Realised Workout Intensity',
        //Color bar
        seriesColor: charts.Color.white,
        domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
        measureFn: (ExerciseIntensity exo, _) => exo.intensity,
        data: realisedData,
      ),
    ];
    return InWorkoutExerciseIntensity(
      data,
      animate: false,
    );
  }

  static List<charts.Series<ExerciseIntensity, String>> _createSampleData() {
    final data = [
      ExerciseIntensity(exerciseName: "Dips", intensity: 45),
      ExerciseIntensity(exerciseName: "Pull Ups", intensity: 60),
      ExerciseIntensity(exerciseName: "Bench Press", intensity: 35),
      ExerciseIntensity(exerciseName: "Curl", intensity: 15),
    ];

    final refData = [
      ExerciseIntensity(exerciseName: "Dips", intensity: 35),
      ExerciseIntensity(exerciseName: "Pull Ups", intensity: 40),
      ExerciseIntensity(exerciseName: "Bench Press", intensity: 25),
      ExerciseIntensity(exerciseName: "Curl", intensity: 25),
    ];

    return [
      charts.Series<ExerciseIntensity, String>(
        id: 'Workout Ref intensity',
        displayName: "Reference Workout Intensity",
        //Color bar
        seriesColor: charts.Color.fromHex(code: "#bcbcbc"),
        domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
        measureFn: (ExerciseIntensity exo, _) => exo.intensity,
        data: refData,
      ),
      charts.Series<ExerciseIntensity, String>(
        id: 'Realised Workout Intensity',
        displayName: 'Realised Workout Intensity',
        //Color bar
        seriesColor: charts.Color.white,
        domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
        measureFn: (ExerciseIntensity exo, _) => exo.intensity,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      defaultInteractions: true,
      primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, color: charts.MaterialPalette.white),
      )),
      domainAxis: const charts.AxisSpec<String>(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, color: charts.MaterialPalette.white),
      )),
    );
  }
}
