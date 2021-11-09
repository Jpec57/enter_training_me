import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/views/end/rename_training_dialog.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/analysis/current/workout_exercise_intensity_graph.dart';
import 'package:enter_training_me/widgets/dialog/change_exercise_set_dialog.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_summary_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
part 'end_workout_analysis.dart';

class WorkoutEndView extends StatefulWidget {
  final TabController tabController;
  final BuildContext parentBuildContext;
  final int? referenceId;
  const WorkoutEndView(
      {Key? key,
      this.referenceId,
      required this.tabController,
      required this.parentBuildContext})
      : super(key: key);

  @override
  _WorkoutEndViewState createState() => _WorkoutEndViewState();
}

class _WorkoutEndViewState extends State<WorkoutEndView> {
  late Future<Training>? _referenceTrainingFuture;
  bool _isTrainingSaved = false;

  @override
  void initState() {
    super.initState();
    _referenceTrainingFuture = widget.referenceId != null
        ? RepositoryProvider.of<TrainingRepository>(context)
            .get(widget.referenceId!)
        : null;
  }

  void saveTrainingInPersonal(InWorkoutState state) async {
    Get.dialog(Dialog(
      backgroundColor: CustomTheme.darkGrey.withAlpha(150),
      child: const Center(child: CircularProgressIndicator()),
    ));
    bool isSuccess = false;
    if (_isTrainingSaved) {
      isSuccess = await RepositoryProvider.of<TrainingRepository>(context)
          .removeFromSavedTrainingAction(state.realisedTrainingId!);
    } else {
      isSuccess = await RepositoryProvider.of<TrainingRepository>(context)
          .saveTrainingAction(state.realisedTrainingId!);
    }
    if (isSuccess) {
      setState(() {
        _isTrainingSaved = !_isTrainingSaved;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _renderAddNewExerciseSection(Training realisedTraining, bool isEnd) {
    if (realisedTraining.exercises.isNotEmpty && isEnd) {
      return Container();
    }
    return InkWell(
      onTap: () {
        BlocProvider.of<InWorkoutBloc>(context).add(ChangedViewEvent(
            widget.tabController, InWorkoutView.newExerciseView));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.add_circle, color: Colors.white),
          Text("Add an exercise"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<InWorkoutBloc, InWorkoutState>(
                      buildWhen: (prev, next) =>
                          prev.realisedTraining != next.realisedTraining,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, right: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      state.realisedTraining.name,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  state.isNewWorkout
                                      ? IconButton(
                                          onPressed: () {
                                            Get.dialog(RenameTrainingDialog(
                                                initialValue:
                                                    state.realisedTraining.name,
                                                callback: (str) {
                                                  BlocProvider.of<
                                                              InWorkoutBloc>(
                                                          context)
                                                      .add(
                                                          ChangedTrainingNameEvent(
                                                              str));
                                                }));
                                          },
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white))
                                      : Container()
                                ],
                              ),
                            ),
                            const SectionDivider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Wrap(
                                spacing: 24,
                                children: [
                                  WorkoutMetric(
                                      metric: "${state.elapsedTime ~/ 60}",
                                      unit: " min"),
                                  WorkoutMetric(
                                      metric: state.realisedTraining.intensity
                                          .toStringAsFixed(1),
                                      unit: " points"),
                                  InkWell(
                                    onTap: () {
                                      Get.dialog(ChangeExerciseSetDialog<int>(
                                        currentValue: state
                                            .realisedTraining.numberOfLoops,
                                        title:
                                            "How many loops do you want to do ?",
                                        setForOneCallback: (value) {
                                          int parseValue = int.parse(value);

                                          BlocProvider.of<InWorkoutBloc>(
                                                  widget.parentBuildContext)
                                              .add(ChangedNbLoopsEvent(
                                                  parseValue));
                                        },
                                      ));
                                    },
                                    child: WorkoutMetric(
                                        metric: state
                                            .realisedTraining.numberOfLoops
                                            .toString(),
                                        unit: " cycle(s)"),
                                  ),
                                  state.realisedTraining.numberOfLoops > 1
                                      ? InkWell(
                                          onTap: () {
                                            Get.dialog(
                                                ChangeExerciseSetDialog<int>(
                                              currentValue: state
                                                  .realisedTraining
                                                  .restBetweenCycles,
                                              title:
                                                  "How many seconds of rest between each loop ?",
                                              setForOneCallback: (value) {
                                                int parseValue =
                                                    int.parse(value);

                                                BlocProvider.of<InWorkoutBloc>(
                                                        widget
                                                            .parentBuildContext)
                                                    .add(
                                                        ChangedRestBetweenLoopsEvent(
                                                            parseValue));
                                              },
                                            ));
                                          },
                                          child: WorkoutMetric(
                                              metric: Utils.convertToDuration(
                                                  state.realisedTraining
                                                      .restBetweenCycles),
                                              unit: " / cycle"),
                                        )
                                      : Container(),
                                  BlocBuilder<InWorkoutBloc, InWorkoutState>(
                                    buildWhen: (prev, next) =>
                                        prev.realisedTrainingId !=
                                        next.realisedTrainingId,
                                    builder: (context, state) {
                                      if (state.realisedTrainingId == null) {
                                        return Container();
                                      }
                                      return IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () =>
                                            saveTrainingInPersonal(state),
                                        icon: Icon(
                                            _isTrainingSaved
                                                ? Icons.bookmark
                                                : Icons.bookmark_border,
                                            color: Colors.white,
                                            size: 25),
                                      );
                                    },
                                  ),
                                  BlocBuilder<InWorkoutBloc, InWorkoutState>(
                                    buildWhen: (prev, next) =>
                                        prev.realisedTrainingId !=
                                        next.realisedTrainingId,
                                    builder: (context, state) {
                                      if (state.realisedTrainingId == null) {
                                        return Container();
                                      }
                                      return IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.share,
                                              size: 25, color: Colors.white),
                                          onPressed: () async {
                                            //TODO SHOW POP UP

                                            bool isSuccess =
                                                await RepositoryProvider.of<
                                                            TrainingRepository>(
                                                        context)
                                                    .shareByEmailAction(state
                                                        .realisedTrainingId!);
                                          });
                                    },
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 16),
                              child: SectionDivider(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: _renderAddNewExerciseSection(
                                  state.realisedTraining, state.isEnd),
                            ),
                            _renderWorkoutAnalysisSection(
                                state.realisedTraining, state.isEnd),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<InWorkoutBloc>(context)
                    .add(TrainingLeftEvent());
              },
              child: const Text("End training"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderWorkoutAnalysisSection(Training realisedTraining, bool isEnd) {
    if (realisedTraining.exercises.isEmpty) {
      return Container();
    }
    if (!isEnd) {
      return Container();
    }
    return FutureBuilder(
      future: _referenceTrainingFuture,
      builder: (BuildContext context, AsyncSnapshot<Training?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return EndWorkoutAnalysis(
              realisedTraining: realisedTraining,
              referenceTraining: snapshot.data);
        }
        return EndWorkoutAnalysis(
            realisedTraining: realisedTraining, referenceTraining: null);
      },
    );
  }
}
