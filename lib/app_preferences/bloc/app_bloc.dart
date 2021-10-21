import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is OnInitEvent) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      String? soundState =
          await storage.read(key: StorageConstants.soundInWorkoutKey);
      if (soundState == "on") {
        yield state.copyWith(soundInWorkout: SoundInWorkout.on);
      }
    }
    if (event is OnPreferenceChangedEvent) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      switch (event.preferenceName) {
        case StorageConstants.soundInWorkoutKey:
          if (StorageConstants.soundInWorkoutValues.contains(event.value)) {
            await storage.write(
                key: StorageConstants.soundInWorkoutKey, value: event.value);
            if (event.value == StorageConstants.soundInWorkoutOn) {
              yield state.copyWith(soundInWorkout: SoundInWorkout.on);
            }
            if (event.value == StorageConstants.soundInWorkoutOff) {
              yield state.copyWith(soundInWorkout: SoundInWorkout.off);
            }
          } else {
            debugPrint(
                "Invalid value for key ${event.preferenceName}: ${event.value}");
          }
      }
    }
  }
}
