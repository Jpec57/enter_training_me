import 'package:ctraining/custom_theme.dart';
import 'package:ctraining/pages/in_workout/ui_parts/current_exercise_details.dart';
import 'package:ctraining/pages/in_workout/ui_parts/training_progress_bar.dart';
import 'package:flutter/material.dart';

class InWorkoutExerciseView extends StatefulWidget {
  const InWorkoutExerciseView({Key? key}) : super(key: key);

  @override
  _InWorkoutExerciseViewState createState() => _InWorkoutExerciseViewState();
}

class _InWorkoutExerciseViewState extends State<InWorkoutExerciseView> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: CurrentExerciseDetail()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("Execution Style", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              ),
              Text("Do it well but do it quick"),
            ],
          ),
        ),

      ],
    );
  }
}
