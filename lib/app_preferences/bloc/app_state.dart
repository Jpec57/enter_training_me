part of 'app_bloc.dart';

enum SoundInWorkout { off, on }

class AppState extends Equatable {
  final SoundInWorkout soundInWorkout;
  const AppState({this.soundInWorkout = SoundInWorkout.off});

  AppState copyWith({SoundInWorkout? soundInWorkout}) =>
      AppState(soundInWorkout: soundInWorkout ?? this.soundInWorkout);

  @override
  List<Object> get props => [soundInWorkout];
}
