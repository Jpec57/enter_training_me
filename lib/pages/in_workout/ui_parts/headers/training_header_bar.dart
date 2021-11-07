import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/ui_parts/headers/training_progress_bar.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TrainingHeaderBar extends StatelessWidget {
  const TrainingHeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.dialog(ConfirmDialog(
                  title: "Quit training",
                  message: "Would you like to quit the current training ?",
                  confirmCallback: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<InWorkoutBloc>(context)
                        .add(TrainingEndedEvent());
                  },
                ));
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
              buildWhen: (prev, next) => prev.elapsedTime != next.elapsedTime,
              builder: (context, state) {
                return Text(
                  Utils.convertToTime(state.elapsedTime),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          Flexible(
              child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
            buildWhen: (prev, next) =>
                prev.currentView != next.currentView ||
                prev.currentSetIndex != next.currentExoIndex ||
                prev.currentSetIndex != next.currentSetIndex,
            builder: (context, state) {
              return TrainingProgressBar(
                progress: state.progress,
              );
            },
          )),
          BlocBuilder<AppBloc, AppState>(
            buildWhen: (prev, next) =>
                prev.soundInWorkout != next.soundInWorkout,
            builder: (context, state) {
              bool isSoundOn = state.soundInWorkout == SoundInWorkout.on;
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<AppBloc>(context).add(
                        OnPreferenceChangedEvent(
                            preferenceName: StorageConstants.soundInWorkoutKey,
                            value: isSoundOn
                                ? StorageConstants.soundInWorkoutOff
                                : StorageConstants.soundInWorkoutOn));
                  },
                  icon: Icon(
                    isSoundOn ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ));
            },
          )
        ],
      ),
    );
  }
}
