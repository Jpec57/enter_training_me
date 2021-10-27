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
      Training editedTraining = Training.clone(state.training);
      List<RealisedExercise> exos = editedTraining.cycles[0].exercises;
      RealisedExercise tmpExo = exos[event.secondIndex];
      // for (var cycle in cycles){

      // }
      exos[event.secondIndex] = exos[event.firstIndex];
      exos[event.firstIndex] = tmpExo;

      yield state.copyWith(training: editedTraining);
    }
    if (event is RemovedExerciseEvent) {
      Training editedTraining = Training.clone(state.training);
      // editedTraining.cycles
      yield state.copyWith(training: editedTraining);
    } else if (event is ToggledEditModeEvent) {
      yield state.copyWith(isEditting: !state.isEditting);
    }
  }
}
