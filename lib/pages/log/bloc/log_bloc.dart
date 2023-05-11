import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/paginated_list_response.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final TrainingRepository trainingRepository;
  final int userId;

  LogBloc({required this.trainingRepository, required this.userId})
      : super(LogTrainingLoadingState(const LogState(page: 0, limit: 1))) {
    on<LoadLastTrainingEvent>(_onLoadLastTrainingEvent);
    on<LoadPreviousTrainingEvent>(_onLoadPreviousTrainingEvent);
    on<LoadNextTrainingEvent>(_onLoadNextTrainingEvent);
  }

  _onLoadLastTrainingEvent(
      LoadLastTrainingEvent event, Emitter<LogState> emit) async {
    String? errorMessage;
    try {
      emit(LogTrainingLoadingState(state));
      PaginatedListResponse<Training> trainingPaginationResponse =
          await trainingRepository.getUserTrainings(userId, limit: 1, page: 0);
      List<Training>? trainings = trainingPaginationResponse.entities;
      if (trainings.isEmpty) {
        emit(LogTrainingErrorState(
            baseState: state,
            lastEvent: event,
            errorMessage: "No training available."));
      } else {
        print(trainingPaginationResponse);
        emit(LogTrainingLoadedState(
            baseState: LogState(
                page: 0,
                hasNext: trainingPaginationResponse.hasNext,
                hasPrevious: trainingPaginationResponse.hasPrevious),
            visibleTraining: trainings[0]));
      }
    } on Exception catch (e) {
      errorMessage = (e is DioError) ? e.message : Utils.defaultErrorMessage;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage ?? ''));
    }
  }

  _onLoadPreviousTrainingEvent(
      LoadPreviousTrainingEvent event, Emitter<LogState> emit) async {
    String? errorMessage;
    try {
      emit(LogTrainingLoadingState(state));
      PaginatedListResponse<Training> trainingPaginationResponse =
          await trainingRepository.getUserTrainings(userId,
              limit: 1, page: state.page + 1);
      List<Training>? trainings = trainingPaginationResponse.entities;
      if (trainings.isEmpty) {
        emit(LogTrainingErrorState(
            baseState: state,
            lastEvent: event,
            errorMessage: "An error occured..."));
      } else {
        emit(LogTrainingLoadedState(
            baseState: LogState(
                page: state.page + 1,
                hasNext: trainingPaginationResponse.hasNext,
                hasPrevious: trainingPaginationResponse.hasPrevious),
            visibleTraining: trainings[0]));
      }
    } on Exception catch (e) {
      errorMessage = (e is DioError) ? e.message : Utils.defaultErrorMessage;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage ?? ''));
    }
  }

  _onLoadNextTrainingEvent(
      LoadNextTrainingEvent event, Emitter<LogState> emit) async {
    String? errorMessage;
    try {
      if (state.page > 0) {
        emit(LogTrainingLoadingState(state));
        PaginatedListResponse<Training> trainingPaginationResponse =
            await trainingRepository.getUserTrainings(userId,
                limit: 1, page: state.page - 1);
        List<Training>? trainings = trainingPaginationResponse.entities;
        if (trainings.isEmpty) {
          emit(LogTrainingErrorState(
              baseState: state,
              lastEvent: event,
              errorMessage: "An error occured..."));
        } else {
          emit(LogTrainingLoadedState(
              baseState: LogState(
                  page: state.page - 1,
                  hasNext: trainingPaginationResponse.hasNext,
                  hasPrevious: trainingPaginationResponse.hasPrevious),
              visibleTraining: trainings[0]));
        }
      } else {
        // emit();
      }
    } on Exception catch (e) {
      errorMessage = (e is DioError) ? e.message : Utils.defaultErrorMessage;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage ?? ''));
    }
  }
}
