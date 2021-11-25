part of 'log_bloc.dart';

class LogState extends Equatable {
  final int page;
  final int limit;
  final bool hasNext;
  final bool hasPrevious;
  const LogState(
      {required this.page,
      this.limit = 1,
      this.hasNext = false,
      this.hasPrevious = false});
  @override
  List<Object> get props => [page, limit, hasNext, hasPrevious];
}

class LogTrainingErrorState extends LogState {
  final LogEvent lastEvent;
  final String errorMessage;

  LogTrainingErrorState(
      {required this.lastEvent,
      required this.errorMessage,
      required LogState baseState})
      : super(
            page: baseState.page,
            limit: baseState.limit,
            hasNext: baseState.hasNext,
            hasPrevious: baseState.hasPrevious);

  @override
  List<Object> get props =>
      [lastEvent, errorMessage, page, limit, hasNext, hasPrevious];
}

class LogTrainingLoadingState extends LogState {
  LogTrainingLoadingState(LogState baseState)
      : super(
            page: baseState.page,
            limit: baseState.limit,
            hasNext: baseState.hasNext,
            hasPrevious: baseState.hasPrevious);

  @override
  List<Object> get props => [page, limit, hasNext, hasPrevious];
}

class LogTrainingLoadedState extends LogState {
  final Training visibleTraining;

  LogTrainingLoadedState(
      {required this.visibleTraining, required LogState baseState})
      : super(
            page: baseState.page,
            limit: baseState.limit,
            hasNext: baseState.hasNext,
            hasPrevious: baseState.hasPrevious);

  @override
  List<Object> get props =>
      [visibleTraining, hasPrevious, hasNext, page, limit];
}
