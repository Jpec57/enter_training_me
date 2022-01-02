import 'package:auto_animated/auto_animated.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/new_exercise_view.dart';
import 'package:enter_training_me/pages/workout_show/bloc/bloc/workout_edit_bloc.dart';
import 'package:enter_training_me/pages/workout_show/views/workout_edit_exercise_card.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/dialog/change_exercise_set_dialog.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class WorkoutShowDescription extends StatefulWidget {
  final bool isEditting;
  final Training referenceTraining;
  const WorkoutShowDescription(
      {Key? key, required this.referenceTraining, this.isEditting = false})
      : super(key: key);

  @override
  State<WorkoutShowDescription> createState() => _WorkoutShowDescriptionState();
}

class _WorkoutShowDescriptionState extends State<WorkoutShowDescription> {
  Widget _renderDeleteTrainingButton(bool isEditting) {
    if (widget.referenceTraining.id == null || !isEditting) {
      return Container();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: CustomTheme.greenGrey,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            bool isSuccess = await RepositoryProvider.of<TrainingRepository>(
                    context)
                .removeFromSavedTrainingAction(widget.referenceTraining.id!);
            if (isSuccess) {
              context.go(HomePage.routeName);
            }
          },
          child: const Text("REMOVE FROM SAVED")),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            bool isSuccess =
                await RepositoryProvider.of<TrainingRepository>(context)
                    .delete(widget.referenceTraining.id!);
            if (isSuccess) {
              context.go(HomePage.routeName);
            }
          },
          child: const Text("DELETE",
              style: TextStyle(fontWeight: FontWeight.bold))),
      const SectionDivider(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.referenceTraining.isOfficial
              ? Container()
              : _renderDeleteTrainingButton(widget.isEditting),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Wrap(
                spacing: 24,
                children: [
                  widget.referenceTraining.estimatedTimeInSeconds != null
                      ? WorkoutMetric(
                          metric:
                              "${widget.referenceTraining.estimatedTimeInSeconds! ~/ 60}",
                          unit: " min")
                      : Container(),
                  BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if (state.isEditting) {
                            showDialog(
                                context: context,
                                builder: (context) => ChangeExerciseSetDialog<
                                        int>(
                                    currentValue: state.training.numberOfLoops,
                                    title: "How many loops do you want to do ?",
                                    setForOneCallback: (value) {
                                      int parseValue = int.parse(value);

                                      BlocProvider.of<WorkoutEditBloc>(context)
                                          .add(ChangedNbLoopsEvent(parseValue));
                                    }));
                          }
                        },
                        child: WorkoutMetric(
                            metric: "${state.training.numberOfLoops}",
                            unit: " cycle(s)"),
                      );
                    },
                  ),
                  Text(widget.referenceTraining.difficulty ?? "UNKNOWN",
                      style: GoogleFonts.bebasNeue(fontSize: 25)),
                ],
              )),
          const SectionDivider(),
          BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
            buildWhen: (prev, next) =>
                prev.training.exercises != next.training.exercises,
            builder: (context, state) {
              List<RealisedExercise> exos = state.training.exercises;
              int exoLength = exos.length;
              return LiveList.options(
                  options: const LiveOptions(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i, Animation<double> animation) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(animation),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: WorkoutEditExerciseCard(
                          exo: exos[i],
                          isEditting: widget.isEditting,
                          currentIndex: i,
                          totalExoCount: exoLength,
                        ),
                      ),
                    );
                  },
                  itemCount: exoLength);
            },
          ),
          BlocBuilder<WorkoutEditBloc, WorkoutEditState>(
            buildWhen: (prev, next) => prev.isEditting != next.isEditting,
            builder: (context, state) {
              if (state.isEditting == false) {
                return Container();
              }
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => NewExerciseView(
                              onExerciseChosen: (RealisedExercise exo) {
                            BlocProvider.of<WorkoutEditBloc>(context)
                                .add(AddedExerciseEvent(exo: exo));
                            Navigator.of(context).pop();
                          }, onDismiss: () {
                            Navigator.of(context).pop();
                          }));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle, color: Colors.white),
                    Text("Add an exercise"),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
