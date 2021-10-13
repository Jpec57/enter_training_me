part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class OnInitEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class OnPreferenceChangedEvent extends AppEvent {
  final String preferenceName;
  final String value;

  const OnPreferenceChangedEvent(
      {required this.preferenceName, required this.value});

  @override
  List<Object> get props => [preferenceName, value];

  @override
  String toString() {
    return "OnPreferenceChangedEvent key: $preferenceName => value: $value";
  }
}
