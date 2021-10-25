import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/widgets/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class InWorkoutExerciseView extends StatefulWidget {
  const InWorkoutExerciseView({Key? key}) : super(key: key);

  @override
  _InWorkoutExerciseViewState createState() => _InWorkoutExerciseViewState();
}

class _InWorkoutExerciseViewState extends State<InWorkoutExerciseView> {
  Widget _renderExerciseInfo(RealisedExercise exo, InWorkoutState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              "${state.currentSetIndex + 1} / ${exo.sets.length} sets",
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                        Get.dialog(CustomDialog<int>(
                                currentValue: state.currentSet.reps,
                                title: "How many reps do you intent to do ?"))
                            .then((value) {
                          if (value != null) {
                            int parseValue = int.parse(value);
                            BlocProvider.of<InWorkoutBloc>(context)
                                .add(ChangedRefRepsEvent(parseValue));
                          }
                        });
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
                          Get.dialog(CustomDialog<double>(
                            title: "How heavy do you intent to lift ?",
                            currentValue: state.currentSet.weight,
                          )).then((value) {
                            if (value != null) {
                              double parseValue = double.parse(value);

                              BlocProvider.of<InWorkoutBloc>(context)
                                  .add(ChangedRefWeightEvent(parseValue));
                            }
                          });
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
                return _renderExerciseInfo(state.currentExo!, state);
              },
            ),
          ),
        ),
      ],
    );
  }
}
