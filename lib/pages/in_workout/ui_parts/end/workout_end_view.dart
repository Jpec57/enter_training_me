import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
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
  Widget _renderExerciseSetRow(ExerciseSet set) {
    // Icon(Icons.arrow_drop_down, color: Colors.red),

    return Card(
      color: CustomTheme.green,
      child: ListTile(
        title: Text("${set.reps}@${set.weight}kgs"),
        trailing: Icon(Icons.arrow_drop_up, color: Colors.green),
      ),
    );
  }

  Widget _renderExerciseCard(RealisedExercise realisedExercise) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: CustomTheme.middleGreen,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(realisedExercise.exerciseReference.name,
                style: Theme.of(context).textTheme.headline2),
            Image.asset(
              "assets/exercises/pull_up.png",
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(color: Colors.white70, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Sets", style: TextStyle()),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: realisedExercise.sets.length,
                      itemBuilder: (context, index) {
                        ExerciseSet set = realisedExercise.sets[index];
                        return _renderExerciseSetRow(set);
                      }),
                  // ...realisedExercise.sets
                  //     .map((set) => _renderExerciseSetRow(set))
                  //     .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderCycleExercises(ExerciseCycle cycle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cycle.exercises.map((exo) => _renderExerciseCard(exo)).toList(),
    );
  }

  Widget _renderTrainingContent(Training referenceTraining, Training training) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
          children: training.cycles
              .map((cycle) => _renderCycleExercises(cycle))
              .toList()),
    );
  }

  Widget _renderSectionDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Colors.white60,
        height: 1,
      ),
    );
  }

  Widget _renderShortMetric(String metric, String unit) {
    return RichText(
      text: TextSpan(
          text: metric,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          children: [
            TextSpan(
              text: unit,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            )
          ]),
    );
  }

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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.realisedTraining.name,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        _renderSectionDivider(),
                        Wrap(
                          spacing: 24,
                          children: [
                            _renderShortMetric(
                                "${state.elapsedTime ~/ 60}", " min"),
                            _renderShortMetric("420", " points"),
                            Icon(Icons.share, color: Colors.white),
                          ],
                        ),
                        _renderSectionDivider(),
                        _renderTrainingContent(
                            state.referenceTraining, state.realisedTraining),
                        _renderSectionDivider(),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offNamedUntil(HomePage.routeName, (route) => false);
                  },
                  child: Text("End of workout"),
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
