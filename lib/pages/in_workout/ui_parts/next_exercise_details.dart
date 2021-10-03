import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/exercise_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextExerciseDetail extends StatefulWidget {
  const NextExerciseDetail({Key? key}) : super(key: key);

  @override
  State<NextExerciseDetail> createState() => _NextExerciseDetailState();
}

class _NextExerciseDetailState extends State<NextExerciseDetail> {
  Widget _renderExerciseImage() {
    return Image.asset("assets/exercises/pull_up.png");
  }

  Widget _renderNextExoInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("2/3"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  "Next: " + "Pull Up blablabalbalb efezf",
                  style: Theme.of(context).textTheme.headline4,
                )),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _renderExerciseImage(),
                  Expanded(flex: 4, child: _renderNextExoInfo()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
