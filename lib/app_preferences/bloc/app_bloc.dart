import 'package:enter_training_me/storage_constants.dart';
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
    emitSoundPreferences(emit, soundState);
  }

  void _onPreferenceChanged(
      OnPreferenceChangedEvent event, Emitter<AppState> emit) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String key = event.preferenceName;
    String value = event.value;
    bool isKnownKey = true;
    switch (key) {
      case StorageConstants.soundInWorkoutKey:
        emitSoundPreferences(emit, value);
        break;
      default:
        isKnownKey = false;
    }
    if (isKnownKey) {
      await storage.write(key: key, value: value);
    }
  }

  void emitSoundPreferences(Emitter<AppState> emit, String? value) async {
    if (value != null &&
        StorageConstants.soundInWorkoutValues.contains(value)) {
      emit(state.copyWith(soundInWorkout: value));
    }
  }
}
