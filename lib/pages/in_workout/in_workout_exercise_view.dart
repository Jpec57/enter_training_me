import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/current_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/training_progress_bar.dart';
import 'package:flutter/material.dart';

class InWorkoutExerciseView extends StatefulWidget {
  const InWorkoutExerciseView({Key? key}) : super(key: key);

  @override
  _InWorkoutExerciseViewState createState() => _InWorkoutExerciseViewState();
}

class _InWorkoutExerciseViewState extends State<InWorkoutExerciseView> {
  Widget _renderExerciseInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("10", style: Theme.of(context).textTheme.headline1),
            Text("@50kgs", style: Theme.of(context).textTheme.headline4),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                const Text(
                  "Regular Execution Style",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info),
                    color: Colors.white),
              ],
            ),
            const Text(
              "1 / 3 sets",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget _renderExecutionStyleInfo() {
    return Text("Do it well but do it quick");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _renderExerciseInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
