import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/models/reference_exercise.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/exercise_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentExerciseDetail extends StatefulWidget {
  final ReferenceExercise referenceExercise;
  const CurrentExerciseDetail({Key? key, required this.referenceExercise})
      : super(key: key);

  @override
  State<CurrentExerciseDetail> createState() => _CurrentExerciseDetailState();
}

class _CurrentExerciseDetailState extends State<CurrentExerciseDetail> {
  bool _isShowingDescription = false;

  Widget _renderExerciseImage() {
    return Image.asset("assets/exercises/pull_up.png");
  }

  Widget _renderExerciseDescription() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.referenceExercise.description ??
              "No description available.")
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_circle_down_sharp),
                onPressed: () {},
              ),
              Flexible(
                  child: Text(
                widget.referenceExercise.name,
                style: Theme.of(context).textTheme.headline2,
              )),
              IconButton(
                icon: const Icon(Icons.arrow_circle_up_sharp),
                onPressed: () {},
              ),
            ],
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isShowingDescription = !_isShowingDescription;
                });
              },
              child: _isShowingDescription
                  ? _renderExerciseDescription()
                  : _renderExerciseImage(),
            ),
          ),
        ],
      ),
    );
  }
}
