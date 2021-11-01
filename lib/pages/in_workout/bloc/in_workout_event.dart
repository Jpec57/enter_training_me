part of 'in_workout_bloc.dart';

abstract class InWorkoutEvent extends Equatable {
  const InWorkoutEvent();
}

class RestDoneEvent extends InWorkoutEvent {
  const RestDoneEvent();
  // final int restTimeTaken;

  @override
  List<Object?> get props => [];
}

class ExerciseDoneEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class TrainingLeftEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class TrainingEndedEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class TimerTickEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class ChangedViewEvent extends InWorkoutEvent {
  final InWorkoutView view;
  final TabController tabController;

  const ChangedViewEvent(this.tabController, this.view);

  @override
  List<Object?> get props => [view, tabController];
}

class ToggledContentVisibilityEvent extends InWorkoutEvent {
  final bool shouldHideContent;

  const ToggledContentVisibilityEvent(this.shouldHideContent);

  @override
  List<Object?> get props => [shouldHideContent];
}

class RemovedRepEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class AddedRepEvent extends InWorkoutEvent {
  @override
  List<Object?> get props => [];
}

class ChangedRefWeightEvent extends InWorkoutEvent {
  final double weight;
  final bool isForAll;

  const ChangedRefWeightEvent(this.weight, {this.isForAll = false});

  @override
  List<Object?> get props => [weight, isForAll];
}

class ChangedRefRepsEvent extends InWorkoutEvent {
  final int reps;
  final bool isForAll;

  const ChangedRefRepsEvent(this.reps, {this.isForAll = false});

  @override
  List<Object?> get props => [reps, isForAll];
}

class AskedToChangeExoEvent extends InWorkoutEvent {
  final bool isDowngrading;

  const AskedToChangeExoEvent(this.isDowngrading);

  @override
  List<Object?> get props => [isDowngrading];
}

class ChangedExoEvent extends InWorkoutEvent {
  final ReferenceExercise exo;

  const ChangedExoEvent(this.exo);

  @override
  List<Object?> get props => [exo];
}

class ChangedNbSetEvent extends InWorkoutEvent {
  final int nbSets;

  const ChangedNbSetEvent(this.nbSets);

  @override
  List<Object?> get props => [nbSets];
}

class AddedExoEvent extends InWorkoutEvent {
  final RealisedExercise exo;
  final TabController tabController;
  const AddedExoEvent(this.tabController, this.exo);

  @override
  List<Object?> get props => [tabController, exo];
}

class ChangedTrainingNameEvent extends InWorkoutEvent {
  final String name;

  const ChangedTrainingNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}
