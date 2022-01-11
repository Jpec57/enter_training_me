import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_view_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewExerciseSection extends StatelessWidget {
  final TabController tabController;
  const AddNewExerciseSection({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<InWorkoutBloc>(context).add(
            ChangedViewEvent(tabController, InWorkoutView.newExerciseView));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Not done ?"),
          Text("Add an exercise"),
        ],
      ),
    );
  }
}
