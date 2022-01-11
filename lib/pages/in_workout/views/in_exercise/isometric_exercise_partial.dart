import 'dart:async';

import 'package:enter_training_me/mixins/bip_player_mixin.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsometricExercisePartial extends StatefulWidget {
  final BuildContext parentContext;
  final RealisedExercise exo;
  final int durationGoal;
  const IsometricExercisePartial(
      {Key? key,
      required this.parentContext,
      required this.exo,
      required this.durationGoal})
      : super(key: key);

  @override
  _IsometricExercisePartialState createState() =>
      _IsometricExercisePartialState();
}

class _IsometricExercisePartialState extends State<IsometricExercisePartial>
    with SingleTickerProviderStateMixin, BipPlayerMixin {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer?.cancel();
    BlocProvider.of<InWorkoutBloc>(context).add(ResetRepEvent());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      BlocProvider.of<InWorkoutBloc>(context).add(AddedRepEvent());
      playBipIfShould(timer.tick, widget.durationGoal,
          warningTicks: [widget.durationGoal - 1, widget.durationGoal - 2]);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<InWorkoutBloc, InWorkoutState>(
                buildWhen: (prev, next) =>
                    prev.reallyDoneReps != next.reallyDoneReps,
                builder: (context, state) {
                  return Text(state.reallyDoneReps.toString(),
                      style: Theme.of(context).textTheme.headline1);
                },
              ),
              Text("sec", style: Theme.of(context).textTheme.headline4)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("GOAL:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                BlocBuilder<InWorkoutBloc, InWorkoutState>(
                  buildWhen: (prev, next) =>
                      prev.currentExo != next.currentExo ||
                      prev.currentSet != next.currentSet,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("${state.currentSet.reps} sec"),
                        ),
                        state.currentSet.weight != null &&
                                state.currentSet.weight! > 0
                            ? Text("@${state.currentSet.weight}kgs")
                            : Container()
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
