import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'in_workout_event.dart';
part 'in_workout_state.dart';

class InWorkoutBloc extends Bloc<InWorkoutEvent, InWorkoutState> {
  InWorkoutBloc() : super(InWorkoutInitial());

  @override
  Stream<InWorkoutState> mapEventToState(
    InWorkoutEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
