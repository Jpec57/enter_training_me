import 'dart:async';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/headers/training_header_bar.dart';
import 'package:enter_training_me/pages/in_workout/views/in_exercise/current_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/views/in_exercise/in_workout_exercise_view.dart';
import 'package:enter_training_me/pages/in_workout/views/rest/in_workout_rest_view.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/exercise_container.dart';
import 'package:enter_training_me/pages/in_workout/views/rest/next_exercise_details.dart';
import 'package:enter_training_me/pages/in_workout/views/end/workout_end_view.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/new_exercise_view.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:wakelock/wakelock.dart';

class InWorkoutPage extends StatefulWidget {
  final int? referenceTrainingId;

  static const name = "InWorkoutPage";
  static const routeName = "/in/workout";

  const InWorkoutPage({Key? key, required this.referenceTrainingId})
      : super(key: key);

  @override
  State<InWorkoutPage> createState() => _InWorkoutPageState();
}

class _InWorkoutPageState extends State<InWorkoutPage>
    with RestorationMixin, WidgetsBindingObserver {
  late Future<Training?> _trainingFuture;
  RestorableInt   = RestorableInt(0);
  RestorableInt _currentSetIndex = RestorableInt(0);


  @override
  void initState() {
    if (widget.referenceTrainingId != null) {
      _trainingFuture = RepositoryProvider.of<TrainingRepository>(context)
          .get(widget.referenceTrainingId!);
    } else {
      _trainingFuture = Future.value(Training.empty());
    }
    super.initState();
    print("initstate");
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didHaveMemoryPressure() {
    print("didHaveMemoryPressure");
    //TODO SAVE TRAINING PROGRESS HERE
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState");
    print(state);
    //TODO SAVE TRAINING PROGRESS HERE
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    print("didPushRouteInformation");
    print(didPushRouteInformation);
    return didPushRoute(routeInformation.location!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _trainingFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('error'.tr),
          );
        }
        final router = GoRouter.of(context);
        return BlocProvider(
          create: (BuildContext context) => InWorkoutBloc(
            router,
            RepositoryProvider.of<TrainingRepository>(context),
            snapshot.data?.id,
            Training.clone(snapshot.data),
          ),
          child: const InWorkoutScreen(),
        );
      },
    );
  }

  @override
  String? get restorationId => InWorkoutPage.routeName;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    print("Trying to restore state...");
    print('oldBucket');
    print(oldBucket);
    print('initialRestore');
    print(initialRestore);
  }
}

Future<void> restoreTrainingContext() async {
  debugPrint("Restoring training context");
  //Current Exo, Set, isResting or not
  // var box = await Hive.openBox('trainingBox');
  var box = await Hive.openBox('tBox');
  var currentExoIndex = box.get('currentExoIndex');
  var currentSetIndex = box.get('currentSetIndex');
  print('currentExoIndex');
  print(currentExoIndex);
  print('currentSetIndex');
  print(currentSetIndex);
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
            onExerciseChosen: (exercise) {
              BlocProvider.of<InWorkoutBloc>(context)
                  .add(AddedExoEvent(_tabController, exercise));
            },
            onDismiss: () {
              if (state.realisedTraining.exercises.isEmpty) {
                BlocProvider.of<InWorkoutBloc>(context).add(ChangedViewEvent(
                    _tabController, InWorkoutView.endWorkoutView));
              } else {
                BlocProvider.of<InWorkoutBloc>(context).add(
                    ChangedViewEvent(_tabController, InWorkoutView.inRestView));
              }
            },
          );
        }
        if (state.currentExo == null ||
            state.isEnd ||
            state.currentView == InWorkoutView.endWorkoutView) {
          return WorkoutEndView(
              parentBuildContext: context,
              tabController: _tabController,
              referenceId: state.referenceTrainingId);
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TrainingHeaderBar(),
              _renderExerciseHeader(),
              BlocBuilder<InWorkoutBloc, InWorkoutState>(
                buildWhen: (prev, next) => prev.currentExo != next.currentExo,
                builder: (context, state) {
                  if (state.currentExo == null) {
                    return Container();
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                InWorkoutExerciseView(
                                    parentBuildContext: context),
                                InWorkoutRestView(
                                  tabController: _tabController,
                                  onTimerEndCallback: onExerciseSetEnd,
                                )
                              ]),
                        ),
                        _renderDoneButton(context),
                      ],
                    ),
                  );
                },
              ),
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
