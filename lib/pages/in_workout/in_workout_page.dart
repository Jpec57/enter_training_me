import 'dart:async';
import 'dart:math';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/headers/training_header_bar.dart';
import 'package:enter_training_me/pages/in_workout/views/in_exercise/current_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/views/in_exercise/in_workout_exercise_view.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/choose_exercise_dialog.dart';
import 'package:enter_training_me/pages/in_workout/views/rest/in_workout_rest_view.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/exercise_container.dart';
import 'package:enter_training_me/pages/in_workout/views/rest/next_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/views/end/workout_end_view.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

part 'views/new_exercise/new_exercise_view.dart';

class InWorkoutPage extends StatelessWidget {
  final Training? referenceTraining;

  static const routeName = "/workout/in";

  const InWorkoutPage({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => InWorkoutBloc(
          RepositoryProvider.of<TrainingRepository>(context),
          referenceTraining?.id,
          Training.clone(referenceTraining)),
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
    Wakelock.enable();
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
      buildWhen: (prev, next) =>
          prev.isEnd != next.isEnd ||
          next.currentExo == null ||
          prev.currentView != next.currentView,
      builder: (context, state) {
        if (state.currentView == InWorkoutView.newExerciseView) {
          return NewExerciseView(
            tabController: _tabController,
          );
        }
        if (state.currentExo == null ||
            state.isEnd ||
            state.currentView == InWorkoutView.endWorkoutView) {
          return WorkoutEndView(
              tabController: _tabController,
              referenceId: state.referenceTrainingId);
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TrainingHeaderBar(),
              _renderExerciseHeader(),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      const InWorkoutExerciseView(),
                      InWorkoutRestView(
                        tabController: _tabController,
                        onTimerEndCallback: onExerciseSetEnd,
                      )
                    ]),
              ),
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
      BlocProvider.of<InWorkoutBloc>(context).add(const RestDoneEvent());
    }
    _tabController.animateTo((_tabController.index == 0) ? 1 : 0);
    setState(() {});
  }

  Widget _renderDoneButton(BuildContext context) {
    if (_tabController.index == 1) {
      return Container(
        decoration: const BoxDecoration(
            color: CustomTheme.middleGreen,
            // color: CustomTheme.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Text("How many reps have you done ?",
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<InWorkoutBloc>(context)
                            .add(RemovedRepEvent());
                      },
                      icon: const Icon(Icons.remove_circle)),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomTheme.darkGrey,
                      ),
                      child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
                        buildWhen: (prev, next) =>
                            prev.reallyDoneReps != next.reallyDoneReps,
                        builder: (context, state) {
                          return Text(state.reallyDoneReps.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ));
                        },
                      )),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<InWorkoutBloc>(context)
                            .add(AddedRepEvent());
                      },
                      icon: const Icon(Icons.add_circle))
                ],
              ),
            ),
          ],
        ),
      );
    }
    return InkWell(
        onTap: onExerciseSetEnd,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: CustomTheme.darkGrey,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: Text(
              "Done".toUpperCase(),
              style: Theme.of(context).textTheme.headline3,
            ))));
  }

  Widget _renderExerciseHeader() {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: MediaQuery.of(context).size.height *
            ((_tabController.index == 0) ? 0.4 : 0.3),
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
                        nextExercise: state.nextExo,
                        tabController: _tabController);
                  },
                ),
        ));
  }
}
