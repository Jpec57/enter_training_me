import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:enter_training_me/widgets/dialog/return_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
  int? currentSetRestTime;

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
                    mainAxisSize: MainAxisSize.min,
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
                    ],
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.white),
                    onPressed: () async {
                      currentSetRestTime = currentSetRestTime ??
                          state.currentExo!.restBetweenSet;

                      if (currentSetRestTime! - 10 > 0) {
                        setState(() {
                          currentSetRestTime = currentSetRestTime! - 10;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.dialog(ReturnDialog<int>(
                            title: "Change rest time",
                            currentValue: state.currentExo!.restBetweenSet,
                            description:
                                "Change the rest time for this exercise.\nTo change it only temporarily for this set, simply use the '-' and '+' buttons.",
                            callback: (String rest) async {
                              int parsedValue = int.parse(rest);
                              if (parsedValue > 0) {
                                BlocProvider.of<InWorkoutBloc>(context)
                                    .add(ChangedRestEvent(parsedValue));
                              }
                            }));
                      },
                      child: CountdownTimer(
                        totalDuration: currentSetRestTime ??
                            state.currentExo!.restBetweenSet,
                        backgroundColor: CustomTheme.darkGrey,
                        isIncludingStop: true,
                        onEndCallback: widget.onTimerEndCallback,
                        progressStrokeColor: CustomTheme.middleGreen,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                    onPressed: () async {
                      currentSetRestTime = currentSetRestTime ??
                          state.currentExo!.restBetweenSet;
                      setState(() {
                        currentSetRestTime = currentSetRestTime! + 10;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
