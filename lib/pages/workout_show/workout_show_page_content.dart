import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/workout_show/bloc/bloc/workout_edit_bloc.dart';
import 'package:enter_training_me/pages/workout_show/views/workout_description.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WorkoutShowPageContent extends StatefulWidget {
  final Training referenceTraining;

  const WorkoutShowPageContent({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutShowPageContent> createState() => _WorkoutShowPageContentState();
}

class _WorkoutShowPageContentState extends State<WorkoutShowPageContent>
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
        ),
        actions: [
          BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
            buildWhen: (prev, next) => prev.isEditting != next.isEditting,
            builder: (context, state) {
              bool isEditting = state.isEditting;
              return IconButton(
                icon: Icon(isEditting ? Icons.save : Icons.edit,
                    color: Colors.white),
                onPressed: () async {
                  if (isEditting) {
                    //
                  }
                  BlocProvider.of<WorkoutEditBloc>(context)
                      .add(ToggledEditModeEvent());
                },
              );
            },
          ),
        ],
      ),
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
                BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
                  buildWhen: (prev, next) => prev.isEditting != next.isEditting,
                  builder: (context, state) {
                    return WorkoutShowDescription(
                      referenceTraining: state.training,
                      isEditting: state.isEditting,
                    );
                  },
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