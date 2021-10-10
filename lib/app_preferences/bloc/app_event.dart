part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class OnPreferenceChangedEvent extends AppEvent {
  final String preferenceName;

  const OnPreferenceChangedEvent({required this.preferenceName});

  @override
  List<Object> get props => [preferenceName];
}
