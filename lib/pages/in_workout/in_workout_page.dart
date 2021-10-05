import 'dart:async';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_exercise_view.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_rest_view.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/current_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/exercise_container.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/next_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/training_progress_bar.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/workout_end_view.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class InWorkoutPage extends StatelessWidget {
  final Training referenceTraining;

  static const routeName = "/workout/in";

  const InWorkoutPage({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          InWorkoutBloc(referenceTraining, Training.clone(referenceTraining)),
      child: const InWorkoutScreen(),
    );
  }
}

class InWorkoutScreen extends StatefulWidget {
  const InWorkoutScreen({Key? key}) : super(key: key);

  @override
  _InWorkoutScreenState createState() => _InWorkoutScreenState();
}

class _InWorkoutScreenState extends State<InWorkoutScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Timer? _totalTimeTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _totalTimeTimer?.cancel();
    _totalTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      BlocProvider.of<InWorkoutBloc>(context).add(TimerTickEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _totalTimeTimer?.cancel();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InWorkoutBloc, InWorkoutState>(
      buildWhen: (prev, next) => prev.isEnd != next.isEnd,
      builder: (context, state) {
        if (state.isEnd) {
          return const WorkoutEndView();
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.dialog(ConfirmDialog(
                            title: "Quit training",
                            message:
                                "Would you like to quit the current training ?",
                            confirmCallback: () {
                              Get.toNamed(HomePage.routeName);
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
                        buildWhen: (prev, next) =>
                            prev.elapsedTime != next.elapsedTime,
                        builder: (context, state) {
                          return Text(
                            Utils.convertToTime(state.elapsedTime),
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                    Flexible(
                        child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
                      buildWhen: (prev, next) =>
                          prev.currentSetIndex != next.currentExoIndex ||
                          prev.currentSetIndex != next.currentSetIndex,
                      builder: (context, state) {
                        return TrainingProgressBar(
                          progress: state.progress,
                        );
                      },
                    )),
                  ],
                ),
              ),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height *
                      ((_tabController.index == 0) ? 0.4 : 0.25),
                  child: ExerciseContainer(
                    child: (_tabController.index == 0)
                        ? BlocBuilder<InWorkoutBloc, InWorkoutState>(
                            buildWhen: (prev, next) =>
                                prev.currentExoIndex != next.currentExoIndex,
                            builder: (context, state) {
                              return CurrentExerciseDetail(
                                  referenceExercise: state.currentRefExo);
                            },
                          )
                        : BlocBuilder<InWorkoutBloc, InWorkoutState>(
                            buildWhen: (prev, next) =>
                                prev.currentExoIndex != next.currentExoIndex ||
                                prev.currentSetIndex != next.currentSetIndex,
                            builder: (context, state) {
                              return NextExerciseDetail(
                                  nextExercise: state.nextExo);
                            },
                          ),
                  )),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                const InWorkoutExerciseView(),
                InWorkoutRestView(
                  onTimerEndCallback: onExerciseSetEnd,
                )
              ])),
              _renderDoneButton(context),
            ],
          )),
        );
      },
    );
  }

  void onExerciseSetEnd() {
    if (_tabController.index == 0) {
      BlocProvider.of<InWorkoutBloc>(context).add(ExerciseDoneEvent());
    } else {
      BlocProvider.of<InWorkoutBloc>(context)
          .add(const RestDoneEvent(doneReps: 10));
    }
    _tabController.animateTo((_tabController.index == 0) ? 1 : 0);
    setState(() {});
  }

  Widget _renderDoneButton(BuildContext context) {
    return InkWell(
        onTap: onExerciseSetEnd,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: CustomTheme.darkGrey,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: Text(
              "Done".toUpperCase(),
              style: const TextStyle(fontSize: 30),
            ))));
  }
}
