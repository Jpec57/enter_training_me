import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesPage extends StatelessWidget {
  static const routeName = "/preferences";
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (prev, next) =>
                  prev.soundInWorkout != next.soundInWorkout,
              builder: (context, state) {
                return SwitchListTile(
                    title: const Text(
                      "Sound during workout",
                    ),
                    value: state.soundInWorkout == SoundInWorkout.on,
                    onChanged: (value) {
                      BlocProvider.of<AppBloc>(context).add(
                          OnPreferenceChangedEvent(
                              preferenceName:
                                  StorageConstants.soundInWorkoutKey,
                              value: value
                                  ? StorageConstants.soundInWorkoutOn
                                  : StorageConstants.soundInWorkoutOff));
                    });
              },
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
