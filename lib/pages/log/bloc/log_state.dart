part of 'log_bloc.dart';

class LogState extends Equatable {
  final int page;
  final int limit;
  const LogState({required this.page, this.limit = 1});
  @override
  List<Object> get props => [page, limit];
}

class LogTrainingErrorState extends LogState {
  final LogEvent lastEvent;
  final String errorMessage;

  LogTrainingErrorState(
      {required this.lastEvent,
      required this.errorMessage,
      required LogState baseState})
      : super(page: baseState.page, limit: baseState.limit);

  @override
  List<Object> get props => [lastEvent, errorMessage, page, limit];
}

class LogTrainingLoadingState extends LogState {
  LogTrainingLoadingState(LogState baseState)
      : super(page: baseState.page, limit: baseState.limit);

  @override
  List<Object> get props => [page, limit];
}

class LogTrainingLoadedState extends LogState {
  final Training visibleTraining;
  final bool hasPrevious;
  final bool hasNext;

  LogTrainingLoadedState(
      {required this.visibleTraining,
      this.hasPrevious = true,
      this.hasNext = true,
      required LogState baseState})
      : super(page: baseState.page, limit: baseState.limit);

  @override
  List<Object> get props =>
      [visibleTraining, hasPrevious, hasNext, page, limit];
}
