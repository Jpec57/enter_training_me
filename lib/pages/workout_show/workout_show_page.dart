import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/workout_show/section_title.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/analysis/current/muscle_activation_repartition_graph.dart';
import 'package:enter_training_me/widgets/analysis/current/workout_exercise_intensity_graph.dart';
import 'package:enter_training_me/widgets/analysis/current/training_type_repartition_graph.dart';
import 'package:enter_training_me/widgets/analysis/history/training_history_evolution.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_content.dart';
import 'package:enter_training_me/widgets/workout/workout_training_summary_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'views/workout_info_view.dart';
part 'views/workout_history_view.dart';

class WorkoutShowPage extends StatefulWidget {
  final Training referenceTraining;
  static const routeName = "/workout/show";

  const WorkoutShowPage({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutShowPage> createState() => _WorkoutShowPageState();
}

class _WorkoutShowPageState extends State<WorkoutShowPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.referenceTraining.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TabBar(
                  labelPadding: const EdgeInsets.symmetric(vertical: 8),
                  controller: _tabController,
                  tabs: const [
                    Text("Infos"),
                    Text("Exercises"),
                    Text("History"),
                  ]),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                WorkoutInfoView(referenceTraining: widget.referenceTraining),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WorkoutTrainingContent(
                          referenceTraining: widget.referenceTraining),
                    ],
                  ),
                ),
                WorkoutHistoryView(
                  referenceTraining: widget.referenceTraining,
                ),
              ]),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(InWorkoutPage.routeName,
                    arguments: InWorkoutPageArguments(
                        referenceTraining: widget.referenceTraining));
              },
              child: const Text("Start workout"),
            ),
          ]),
        ),
      ),
    );
  }
}
