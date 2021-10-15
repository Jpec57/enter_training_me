import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  static const routeName = "/test";
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(children: [
            //https://google.github.io/charts/flutter/example/line_charts/stacked_area_custom_color
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: SizedBox(
            //       height: 200,
            //       width: MediaQuery.of(context).size.width * 2,
            //       child: InWorkoutExerciseIntensity.withSampleData()),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //       height: 200,
            //       width: MediaQuery.of(context).size.width,
            //       child: TrainingHistoryEvolution.withSampleData()),
            // )
          ]),
        ));
  }
}
