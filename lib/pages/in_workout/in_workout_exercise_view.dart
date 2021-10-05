import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.currentSet.reps.toString(),
                    style: Theme.of(context).textTheme.headline1),
                state.currentSet.weight != null
                    ? Text("@${state.currentSet.weight}kg",
                        style: Theme.of(context).textTheme.headline4)
                    : Container(),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          state.currentExo.executionStyle != null
                              ? state.currentExo.executionStyle!.name
                              : "Regular Execution Style",
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.info),
                          color: Colors.white),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "${state.currentSetIndex + 1} / ${state.currentExo.sets.length} sets",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _renderExerciseInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
