import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_exercise_card.dart';
import 'package:enter_training_me/widgets/workout/workout_training_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
      body: SafeArea(
        child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
          buildWhen: (prev, next) =>
              prev.realisedTraining != next.realisedTraining,
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8, right: 8),
                          child: Text(
                            state.realisedTraining.name,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        const SectionDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Wrap(
                            spacing: 24,
                            children: [
                              WorkoutMetric(
                                  metric: "${state.elapsedTime ~/ 60}",
                                  unit: " min"),
                              const WorkoutMetric(
                                  metric: "420", unit: " points"),
                              const Icon(Icons.share, color: Colors.white),
                            ],
                          ),
                        ),
                        const SectionDivider(),
                        WorkoutTrainingContent(
                            trainingToCompareWith: state.referenceTraining,
                            referenceTraining: state.realisedTraining),
                        const SectionDivider(),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<InWorkoutBloc>(context)
                        .add(TrainingEndedEvent());
                  },
                  child: const Text("End of workout"),
                  // style: ButtonStyle(backgroundColor: CustomTheme.middleGreen)
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
