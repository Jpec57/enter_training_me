import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/add_new_exercise_section.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InWorkoutRestView extends StatefulWidget {
  final TabController tabController;
  final VoidCallback onTimerEndCallback;
  const InWorkoutRestView(
      {Key? key, required this.onTimerEndCallback, required this.tabController})
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
              if (state.currentExo == null || state.isEndOfWorkout) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Icon(Icons.flag, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AddNewExerciseSection(
                          tabController: widget.tabController,
                        ),
                      )
                    ],
                  ),
                );
              }
              return CountdownTimer(
                totalDuration: state.currentExo!.restBetweenSet,
                backgroundColor: CustomTheme.darkGrey,
                isIncludingStop: true,
                onEndCallback: widget.onTimerEndCallback,
                progressStrokeColor: CustomTheme.middleGreen,
              );
            },
          ),
        ),
      ],
    );
  }
}
