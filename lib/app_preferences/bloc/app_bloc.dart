import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<OnInitEvent>(_onInit);
    on<OnPreferenceChangedEvent>(_onPreferenceChanged);
  }

  void _onInit(OnInitEvent event, Emitter<AppState> emit) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? soundState =
        await storage.read(key: StorageConstants.soundInWorkoutKey);
    if (soundState == "on") {
      emit(state.copyWith(soundInWorkout: SoundInWorkout.on));
    }
  }

  void _onPreferenceChanged(
      OnPreferenceChangedEvent event, Emitter<AppState> emit) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    switch (event.preferenceName) {
      case StorageConstants.soundInWorkoutKey:
        if (StorageConstants.soundInWorkoutValues.contains(event.value)) {
          await storage.write(
              key: StorageConstants.soundInWorkoutKey, value: event.value);
          if (event.value == StorageConstants.soundInWorkoutOn) {
            emit(state.copyWith(soundInWorkout: SoundInWorkout.on));
          }
          if (event.value == StorageConstants.soundInWorkoutOff) {
            emit(state.copyWith(soundInWorkout: SoundInWorkout.off));
          }
        } else {
          debugPrint(
              "Invalid value for key ${event.preferenceName}: ${event.value}");
        }
    }
  }
}
