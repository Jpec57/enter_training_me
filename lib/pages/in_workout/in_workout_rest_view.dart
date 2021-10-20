import 'dart:math';

import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InWorkoutRestView extends StatefulWidget {
  final VoidCallback onTimerEndCallback;
  const InWorkoutRestView({Key? key, required this.onTimerEndCallback})
      : super(key: key);

  @override
  _InWorkoutRestViewState createState() => _InWorkoutRestViewState();
}

class _InWorkoutRestViewState extends State<InWorkoutRestView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
            buildWhen: (prev, next) =>
                prev.currentExoIndex != next.currentExoIndex,
            builder: (context, state) {
              if (state.isEndOfWorkout) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<InWorkoutBloc>(context)
                          .add(const RestDoneEvent());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("End of workout"),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.flag, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: CountdownTimer(
                  totalDuration: state.currentExo.restBetweenSet,
                  backgroundColor: CustomTheme.darkGrey,
                  isIncludingStop: true,
                  onEndCallback: widget.onTimerEndCallback,
                  progressStrokeColor: CustomTheme.middleGreen,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
