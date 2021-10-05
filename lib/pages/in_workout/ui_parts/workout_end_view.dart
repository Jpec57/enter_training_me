import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class WorkoutEndView extends StatefulWidget {
  const WorkoutEndView({Key? key}) : super(key: key);

  @override
  _WorkoutEndViewState createState() => _WorkoutEndViewState();
}

class _WorkoutEndViewState extends State<WorkoutEndView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      appBar: AppBar(),
      body: Container(
          child: Center(
        child: Text("End of workout"),
      )),
    );
  }
}
