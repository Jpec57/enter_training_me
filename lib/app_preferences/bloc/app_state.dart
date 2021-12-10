part of 'app_bloc.dart';

class AppState extends Equatable {
  final String soundInWorkout;
  const AppState({this.soundInWorkout = StorageConstants.soundInWorkoutOff});

  AppState copyWith({String? soundInWorkout}) =>
      AppState(soundInWorkout: soundInWorkout ?? this.soundInWorkout);

  @override
  List<Object> get props => [soundInWorkout];
}
