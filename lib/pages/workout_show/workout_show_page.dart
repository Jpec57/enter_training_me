import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutShowPage extends StatelessWidget {
  final Training referenceTraining;
  static const routeName = "/workout/show";

  const WorkoutShowPage({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          referenceTraining.name,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Wrap(
                        spacing: 24,
                        children: [
                          referenceTraining.estimatedTimeInSeconds != null
                              ? WorkoutMetric(
                                  metric:
                                      "${referenceTraining.estimatedTimeInSeconds! ~/ 60}",
                                  unit: " min")
                              : Container(),
                          const WorkoutMetric(metric: "EXPERT", unit: ""),
                        ],
                      ),
                    ),
                    const SectionDivider(),
                    WorkoutTrainingContent(
                        referenceTraining: referenceTraining),
                    const SectionDivider(),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(InWorkoutPage.routeName,
                    arguments: InWorkoutPageArguments(
                        referenceTraining: referenceTraining));
              },
              child: const Text("Start workout"),
            ),
          ]),
        ),
      ),
    );
  }
}
