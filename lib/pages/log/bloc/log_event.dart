part of 'log_bloc.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object?> get props => [];
}

class LoadLastTrainingEvent extends LogEvent {
  @override
  List<Object> get props => [];
}

class LoadPreviousTrainingEvent extends LogEvent {
  final DateTime referenceDate;

  const LoadPreviousTrainingEvent({required this.referenceDate});

  @override
  List<Object> get props => [referenceDate];
}

class LoadNextTrainingEvent extends LogEvent {
  final DateTime referenceDate;

  const LoadNextTrainingEvent({required this.referenceDate});

  @override
  List<Object> get props => [referenceDate];
}
