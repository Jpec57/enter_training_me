import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/widgets/dialog/change_exercise_set_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class InWorkoutExerciseView extends StatelessWidget {
  const InWorkoutExerciseView({Key? key}) : super(key: key);

  void showModal() {
    // BlocProvider.of<InWorkoutBloc>(context)
    //     .add(const ToggledContentVisibilityEvent(true));

    // BlocProvider.of<InWorkoutBloc>(context)
    //     .add(const ToggledContentVisibilityEvent(false));
  }

  void showSetsModal(BuildContext context, InWorkoutState state) {
    Get.dialog(ChangeExerciseSetDialog<int>(
      currentValue: state.currentSet.reps,
      title: "How many sets do you intent to do ?",
      setForOneCallback: (value) {
        int parseValue = int.parse(value);

        BlocProvider.of<InWorkoutBloc>(context)
            .add(ChangedNbSetEvent(parseValue));
      },
    ));
  }

  void showRepsModal(BuildContext context, InWorkoutState state) {
    Get.dialog(ChangeExerciseSetDialog<int>(
      currentValue: state.currentSet.reps,
      title: "How many reps do you intent to do ?",
      setForAllCallback: (value) {
        int parseValue = int.parse(value);

        BlocProvider.of<InWorkoutBloc>(context)
            .add(ChangedRefRepsEvent(parseValue, isForAll: true));
      },
      setForOneCallback: (value) {
        int parseValue = int.parse(value);

        BlocProvider.of<InWorkoutBloc>(context)
            .add(ChangedRefRepsEvent(parseValue));
      },
    ));
  }

  void showWeightModal(BuildContext context, InWorkoutState state) {
    // BlocProvider.of<InWorkoutBloc>(context)
    //     .add(const ToggledContentVisibilityEvent(true));

    Get.dialog(ChangeExerciseSetDialog<double>(
      title: "How heavy do you intent to lift ?",
      currentValue: state.currentSet.weight,
      showQuickIntIncrease: false,
      setForAllCallback: (value) {
        double parseValue = double.parse(value);

        BlocProvider.of<InWorkoutBloc>(context)
            .add(ChangedRefWeightEvent(parseValue, isForAll: true));
        // BlocProvider.of<InWorkoutBloc>(context)
        //     .add(const ToggledContentVisibilityEvent(false));
      },
      setForOneCallback: (value) {
        double parseValue = double.parse(value);

        BlocProvider.of<InWorkoutBloc>(context)
            .add(ChangedRefWeightEvent(parseValue));
        // BlocProvider.of<InWorkoutBloc>(context)
        //     .add(const ToggledContentVisibilityEvent(false));
      },
    ));
  }

  Widget _renderExerciseInfo(
      BuildContext context, RealisedExercise exo, InWorkoutState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              showSetsModal(context, state);
            },
            child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
              buildWhen: (prev, next) => prev.currentExo != next.currentExo,
              builder: (context, state) {
                return Center(
                  child: Text(
                    "${state.currentSetIndex + 1} / ${exo.sets.length} sets",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        showRepsModal(context, state);
                      },
                      child: Text(state.currentSet.reps.toString(),
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    Text("reps", style: Theme.of(context).textTheme.headline4),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          showWeightModal(context, state);
                        },
                        child: state.currentSet.weight != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("@${state.currentSet.weight}kg",
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              )
                            : Container(),
                      ),
                      exo.executionStyle != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                  exo.executionStyle!.description.toString()),
                            )
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
              buildWhen: (prev, next) =>
                  prev.currentSetIndex != next.currentSetIndex ||
                  prev.currentExoIndex != next.currentExoIndex ||
                  prev.currentCycleIndex != next.currentCycleIndex ||
                  prev.currentExo != next.currentExo,
              builder: (context, state) {
                if (state.currentExo == null) {
                  return Container();
                }
                return _renderExerciseInfo(context, state.currentExo!, state);
              },
            ),
          ),
        ),
      ],
    );
  }
}
