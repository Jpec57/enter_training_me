import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/views/end/rename_training_dialog.dart';
import 'package:enter_training_me/pages/workout_show/bloc/bloc/workout_edit_bloc.dart';
import 'package:enter_training_me/pages/workout_show/views/workout_description.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
  int currentTabIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: currentTabIndex);
    _tabController.addListener(() {
      setState(() {
        currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
          buildWhen: (prev, next) => prev.training.name != next.training.name,
          builder: (context, state) {
            return InkWell(
              onTap: () {
                Get.dialog(RenameTrainingDialog(
                    initialValue: state.training.name,
                    callback: (name) {
                      BlocProvider.of<WorkoutEditBloc>(context)
                          .add(RenamedWorkoutEvent(name));
                    }));
              },
              child: Text(
                "${state.training.name} (${state.training.id})",
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            } else {
              context.go(HomePage.routeName);
            }
          },
        ),
        actions: [
          currentTabIndex == 1
              ? BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
                  buildWhen: (prev, next) =>
                      prev.isEditting != next.isEditting ||
                      _tabController.index == 1,
                  builder: (context, state) {
                    bool isEditting = state.isEditting;
                    return IconButton(
                      icon: Icon(isEditting ? Icons.save : Icons.edit,
                          color: Colors.white),
                      onPressed: () async {
                        if (isEditting) {
                          BlocProvider.of<WorkoutEditBloc>(context)
                              .add(SavedTrainingChangesEvent());
                        } else {
                          BlocProvider.of<WorkoutEditBloc>(context)
                              .add(ToggledEditModeEvent());
                        }
                      },
                    );
                  },
                )
              : Container(),
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
                context.go(InWorkoutPage.routeName.replaceFirst(
                    ':id', widget.referenceTraining.id.toString()));
              },
              child: const Text("Start workout"),
            ),
          ]),
        ),
      ),
    );
  }
}
