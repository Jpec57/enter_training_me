import 'package:bloc/bloc.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:equatable/equatable.dart';

part 'workout_edit_event.dart';
part 'workout_edit_state.dart';

class WorkoutEditBloc extends Bloc<WorkoutEditEvent, WorkoutEditState> {
  WorkoutEditBloc(Training training)
      : super(WorkoutEditState(training: training));

  @override
  Stream<WorkoutEditState> mapEventToState(
    WorkoutEditEvent event,
  ) async* {
    if (event is ChangedExerciseEvent) {
    } else if (event is SwitchedExerciseEvent) {
      List<ExerciseCycle> newCycles = [];
      for (var cycle in state.training.cycles) {
        List<RealisedExercise> cycleExos = [...cycle.exercises];
        RealisedExercise tmpExo = cycleExos[event.secondIndex];
        cycleExos[event.secondIndex] = cycleExos[event.firstIndex];
        cycleExos[event.firstIndex] = tmpExo;
        newCycles.add(cycle.copyWith(exercises: cycleExos));
      }
      yield state.copyWith(
          training: state.training.copyWith(cycles: newCycles));
    } else if (event is RemovedExerciseEvent) {
      Training editedTraining = Training.clone(state.training);
      List<ExerciseCycle> newCycles = [];
      for (var cycle in state.training.cycles) {
        List<RealisedExercise> cycleExos = [...cycle.exercises];
        cycleExos.removeAt(event.exoIndex);
        newCycles.add(cycle.copyWith(exercises: cycleExos));
      }
      yield state.copyWith(
          training: editedTraining.copyWith(cycles: newCycles));
    } else if (event is ToggledEditModeEvent) {
      yield state.copyWith(isEditting: !state.isEditting);
    } else if (event is SavedTrainingChangesEvent) {
      //TODO SAVE WITH PATCH UPDATE TRAINING
      yield state.copyWith(isEditting: !state.isEditting);
    }
  }
}
