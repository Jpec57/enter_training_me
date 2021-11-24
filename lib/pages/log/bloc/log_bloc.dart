import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:equatable/equatable.dart';
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
      List<Training>? trainings =
          await trainingRepository.getUserTrainings(47, limit: 1, page: 0);

      if (trainings.isEmpty) {
        emit(LogTrainingErrorState(
            baseState: state,
            lastEvent: event,
            errorMessage: "No training available."));
      } else {
        emit(LogTrainingLoadedState(
            baseState: const LogState(page: 0), visibleTraining: trainings[0]));
      }
    } on DioError catch (e) {
      errorMessage = e.message;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage));
    }
  }

  _onLoadPreviousTrainingEvent(
      LoadPreviousTrainingEvent event, Emitter<LogState> emit) async {
    String? errorMessage;
    try {
      emit(LogTrainingLoadingState(state));
      List<Training>? trainings =
          await trainingRepository.getUserTrainings(47, limit: 1, page: 1);
      // Training? training = await trainingRepository.getUserLastTraining(userId);
      if (trainings.isEmpty) {
        emit(LogTrainingErrorState(
            baseState: state,
            lastEvent: event,
            errorMessage: "An error occured..."));
      } else {
        emit(LogTrainingLoadedState(
            baseState: LogState(page: state.page - 1),
            visibleTraining: trainings[0]));
      }
    } on DioError catch (e) {
      errorMessage = e.message;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage));
    }
  }

  _onLoadNextTrainingEvent(
      LoadNextTrainingEvent event, Emitter<LogState> emit) async {
    String? errorMessage;
    try {
      emit(LogTrainingLoadingState(state));
      List<Training>? trainings =
          await trainingRepository.getUserTrainings(47, limit: 1, page: 1);
      // Training? training = await trainingRepository.getUserLastTraining(userId);
      if (trainings.isEmpty) {
        emit(LogTrainingErrorState(
            baseState: state,
            lastEvent: event,
            errorMessage: "An error occured..."));
      } else {
        emit(LogTrainingLoadedState(
            baseState: LogState(page: state.page + 1),
            visibleTraining: trainings[0]));
      }
    } on DioError catch (e) {
      errorMessage = e.message;
      emit(LogTrainingErrorState(
          baseState: state, lastEvent: event, errorMessage: errorMessage));
    }
  }
}
