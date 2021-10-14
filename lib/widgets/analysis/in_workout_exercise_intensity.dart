// import 'package:enter_training_me/widgets/analysis/exercise_intensity.dart';
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class InWorkoutExerciseIntensity extends StatelessWidget {
//   final List<charts.Series<ExerciseIntensity, String>> seriesList;
//   final bool animate;

//   const InWorkoutExerciseIntensity(this.seriesList,
//       {Key? key, this.animate = true})
//       : super(key: key);

//   /// Creates a [BarChart] with sample data and no transition.
//   factory InWorkoutExerciseIntensity.withSampleData() {
//     return InWorkoutExerciseIntensity(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<ExerciseIntensity, String>> _createSampleData() {
//     final data = [
//       ExerciseIntensity(exerciseName: "Dips", intensity: 45),
//       ExerciseIntensity(exerciseName: "Pull Ups", intensity: 45),
//       ExerciseIntensity(exerciseName: "Bench Press", intensity: 45),
//       ExerciseIntensity(exerciseName: "Curl", intensity: 45),
//     ];

//     return [
//       charts.Series<ExerciseIntensity, String>(
//         id: 'Workout intensity',
//         domainFn: (ExerciseIntensity exo, _) => exo.exerciseName,
//         measureFn: (ExerciseIntensity exo, _) => exo.intensity,
//         data: data,
//       )
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return charts.BarChart(
//       seriesList,
//       animate: animate,
//       defaultInteractions: true,
//     );
//   }
// }
