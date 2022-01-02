import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/new_exercise_view.dart';
import 'package:enter_training_me/pages/workout_show/bloc/bloc/workout_edit_bloc.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WorkoutEditExerciseCard extends StatelessWidget {
  final int totalExoCount;
  final int currentIndex;
  final bool isEditting;
  final RealisedExercise exo;
  const WorkoutEditExerciseCard(
      {Key? key,
      required this.totalExoCount,
      required this.currentIndex,
      required this.isEditting,
      required this.exo})
      : super(key: key);

  Widget _renderEdittingTools(BuildContext context, int totalExoCount,
      int currentIndex, bool isEditting) {
    if (!isEditting) {
      return Container();
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentIndex > 0
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<WorkoutEditBloc>(context).add(
                        SwitchedExerciseEvent(
                            firstIndex: currentIndex - 1,
                            secondIndex: currentIndex));
                  },
                  icon: const Icon(Icons.arrow_upward, color: Colors.white))
              : const Icon(Icons.arrow_upward, color: Colors.transparent),
          IconButton(
              onPressed: () {
                BlocProvider.of<WorkoutEditBloc>(context)
                    .add(RemovedExerciseEvent(exoIndex: currentIndex));
              },
              icon: const Icon(Icons.delete, color: Colors.white)),
          totalExoCount - 1 > currentIndex
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<WorkoutEditBloc>(context).add(
                        SwitchedExerciseEvent(
                            firstIndex: currentIndex,
                            secondIndex: currentIndex + 1));
                  },
                  icon: const Icon(Icons.arrow_downward, color: Colors.white))
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: CustomTheme.grey,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/exercises/pull_up.png",
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: isEditting
                    ? () async {
                        Get.dialog(NewExerciseView(
                            editedExercise: exo,
                            onExerciseChosen: (exo) {
                              BlocProvider.of<WorkoutEditBloc>(context).add(
                                  ChangedExerciseEvent(
                                      exo: exo, exoIndex: currentIndex));
                              Navigator.of(context).pop();
                            },
                            onDismiss: () {
                              Navigator.of(context).pop();
                            }));
                      }
                    : null,
                child: Container(
                  decoration: const BoxDecoration(
                    color: CustomTheme.middleGreen,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: isEditting ? () {} : null,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(exo.exerciseReference.name,
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: InkWell(
                            onTap: isEditting ? () {} : null,
                            child: Text("=> " +
                                (exo.executionStyle?.name ?? "Regular")),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: isEditting ? () {} : null,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: exo.sets
                                        .map((set) => Text(set.str))
                                        .toList()),
                              ),
                            ),
                            Expanded(
                                child: Center(
                              child: InkWell(
                                onTap:
                                    // isEditting
                                    // ? () async {
                                    //     await Get.dialog(ReturnDialog(
                                    //         title: "How much rest per set?",
                                    //         currentValue: exo.restBetweenSet,
                                    //         callback: (str) async {
                                    //           int rest = int.parse(str);
                                    //           if (rest > 0) {
                                    //             BlocProvider.of<
                                    //                         WorkoutEditBloc>(
                                    //                     context)
                                    //                 .add(ChangedRestEvent(
                                    //                     rest: rest,
                                    //                     exerciseIndex:
                                    //                         currentIndex));
                                    //           }
                                    //         }));
                                    //   }
                                    // :
                                    null,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      "${Utils.convertToDuration(exo.restBetweenSet)}/set"),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _renderEdittingTools(
                context, totalExoCount, currentIndex, isEditting)
          ],
        ));
  }
}
