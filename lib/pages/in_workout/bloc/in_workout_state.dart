part of 'in_workout_bloc.dart';

class InWorkoutState extends Equatable {
  final int? referenceTrainingId;
  final Training realisedTraining;
  final int currentCycleIndex;
  final int currentExoIndex;
  final int currentSetIndex;
  final bool isEnd;
  final int elapsedTime;
  final int? realisedTrainingId;
  final InWorkoutView currentView;
  final bool isAutoPlayOn;

  final int reallyDoneReps;

  const InWorkoutState(
      {this.referenceTrainingId,
      required this.realisedTraining,
      this.isEnd = false,
      this.elapsedTime = 0,
      this.isAutoPlayOn = true,
      this.realisedTrainingId,
      this.currentCycleIndex = 0,
      this.currentExoIndex = 0,
      this.currentView = InWorkoutView.inExerciseView,
      this.currentSetIndex = 0,
      this.reallyDoneReps = 0});

  double get progress {
    int totalDoneSets = 0;
    int totalSets = 0;
    int setPerCycle = 0;
    if (realisedTraining.cycles.isEmpty) {
      return 100;
    }
    List<RealisedExercise> exos = realisedTraining.cycles[0].exercises;
    if (exos.isEmpty) {
      return 100;
    }
    for (var exo in exos) {
      setPerCycle += exo.sets.length;
    }
    totalSets = realisedTraining.cycles.length * setPerCycle;
    //Total set END

    int totalCurrentCycleDoneSets = 0;
    for (int i = 0; i < currentExoIndex; i++) {
      totalCurrentCycleDoneSets += exos[i].sets.length;
    }
    totalCurrentCycleDoneSets += currentSetIndex;

    totalDoneSets =
        (currentCycleIndex * setPerCycle) + totalCurrentCycleDoneSets;
    return totalDoneSets.toDouble() / totalSets;
  }

  bool get isEndOfWorkout => nextExoIndex == null;
  bool get isNewWorkout => referenceTrainingId == null;

  ExerciseCycle? get currentCycle =>
      currentCycleIndex < realisedTraining.cycles.length
          ? realisedTraining.cycles[currentCycleIndex]
          : null;

  RealisedExercise? get currentExo =>
      currentCycle != null && currentExoIndex < currentCycle!.exercises.length
          ? currentCycle!.exercises[currentExoIndex]
          : null;

  ReferenceExercise get currentRefExo => currentExo!.exerciseReference;

  ExerciseSet get currentSet => currentExo!.sets[currentSetIndex];

  int get nextSetIndex {
    if (currentExo == null) {
      return 0;
    }
    int len = currentExo!.sets.length;
    if (currentSetIndex + 1 < len) {
      return currentSetIndex + 1;
    }
    return 0;
  }

  int? get nextExoIndex {
    int nextSetIndex = this.nextSetIndex;
    // Changing exercise
    if (nextSetIndex == 0) {
      int cycleLength = realisedTraining.cycles.length;
      int exerciseLength = currentCycle?.exercises.length ?? 0;
      int currentExoIndex = this.currentExoIndex;
      // Has next exo in cycle
      if (currentExoIndex + 1 < exerciseLength) {
        return currentExoIndex + 1;
      }
      // loop to first exo in cycle
      if (currentCycleIndex + 1 < cycleLength) {
        return 0;
      }
      return null;
    }
    return currentExoIndex;
  }

  RealisedExercise? get nextExo {
    int nextSetIndex = this.nextSetIndex;
    // Changing exercise
    if (nextSetIndex == 0) {
      int cycleLength = realisedTraining.cycles.length;
      int exerciseLength = currentCycle?.exercises.length ?? 0;
      int currentExoIndex = this.currentExoIndex;
      // Has next exo in cycle
      if (currentExoIndex + 1 < exerciseLength) {
        return currentCycle!.exercises[currentExoIndex + 1];
      }
      // loop to first exo in cycle
      if (currentCycleIndex + 1 < cycleLength) {
        return realisedTraining.cycles[currentCycleIndex + 1].exercises[0];
      }
      return null;
    }
    return currentExo;
  }

  List<InWorkoutView> getNonTickingViews() =>
      [InWorkoutView.endWorkoutView, InWorkoutView.newExerciseView];

  @override
  List<Object?> get props => [
        referenceTrainingId,
        realisedTraining,
        currentCycleIndex,
        currentExoIndex,
        currentSetIndex,
        isEnd,
        realisedTrainingId,
        currentView,
        reallyDoneReps,
        elapsedTime,
        isAutoPlayOn
      ];

  InWorkoutState copyWith(
          {int? referenceTrainingId,
          Training? realisedTraining,
          int? currentCycleIndex,
          int? elapsedTime,
          bool? isAutoPlayOn,
          int? currentExoIndex,
          int? currentSetIndex,
          int? realisedTrainingId,
          int? reallyDoneReps,
          double? reallyUsedWeight,
          InWorkoutView? currentView,
          bool? isEnd}) =>
      InWorkoutState(
          isEnd: isEnd ?? this.isEnd,
          isAutoPlayOn: isAutoPlayOn ?? this.isAutoPlayOn,
          referenceTrainingId: referenceTrainingId ?? this.referenceTrainingId,
          elapsedTime: elapsedTime ?? this.elapsedTime,
          currentView: currentView ?? this.currentView,
          realisedTraining: realisedTraining ?? this.realisedTraining,
          currentCycleIndex: currentCycleIndex ?? this.currentCycleIndex,
          currentExoIndex: currentExoIndex ?? this.currentExoIndex,
          currentSetIndex: currentSetIndex ?? this.currentSetIndex,
          realisedTrainingId: realisedTrainingId ?? this.realisedTrainingId,
          reallyDoneReps: reallyDoneReps ?? this.reallyDoneReps);
}
