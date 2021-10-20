import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class InWorkoutExerciseView extends StatefulWidget {
  const InWorkoutExerciseView({Key? key}) : super(key: key);

  @override
  _InWorkoutExerciseViewState createState() => _InWorkoutExerciseViewState();
}

class _InWorkoutExerciseViewState extends State<InWorkoutExerciseView> {
  Widget _renderExerciseInfo() {
    return BlocBuilder<InWorkoutBloc, InWorkoutState>(
      buildWhen: (prev, next) =>
          prev.currentSetIndex != next.currentSetIndex ||
          prev.currentExoIndex != next.currentExoIndex ||
          prev.currentCycleIndex != next.currentCycleIndex,
      builder: (context, state) {
        print("Jpec");
        print(state.currentExo);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  "${state.currentSetIndex + 1} / ${state.currentExo.sets.length} sets",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.currentSet.reps.toString(),
                          style: Theme.of(context).textTheme.headline1),
                      Text("reps",
                          style: Theme.of(context).textTheme.headline4),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        state.currentSet.weight != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("@${state.currentSet.weight}kg",
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    state.currentExo.executionStyle != null
                                        ? state.currentExo.executionStyle!.name
                                        : "Regular Execution Style",
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _renderExecutionStyleInfo(ExecutionStyle execStyle) {
    return Text(execStyle.description.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _renderExerciseInfo(),
        ),
      ],
    );
  }
}
