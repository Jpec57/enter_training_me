part of 'in_workout_bloc.dart';

enum InWorkoutView { inExercise, inRest, end }

class InWorkoutState extends Equatable {
  final Training referenceTraining;
  final Training realisedTraining;
  final int currentCycleIndex;
  final int currentExoIndex;
  final int currentSetIndex;
  final bool isEnd;
  final int elapsedTime;
  final int? realisedTrainingId;
  final InWorkoutView currentView;

  final int reallyDoneReps;

  const InWorkoutState(
      {required this.referenceTraining,
      required this.realisedTraining,
      this.isEnd = false,
      this.elapsedTime = 0,
      this.realisedTrainingId,
      this.currentCycleIndex = 0,
      this.currentExoIndex = 0,
      this.currentView = InWorkoutView.inExercise,
      this.currentSetIndex = 0,
      this.reallyDoneReps = 0});

  double get progress {
    int totalDoneSets = 0;
    int totalSets = 0;
    int setPerCycle = 0;
    List<RealisedExercise> exos = referenceTraining.cycles[0].exercises;
    for (var exo in exos) {
      setPerCycle += exo.sets.length;
    }
    totalSets = referenceTraining.cycles.length * setPerCycle;
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

  ExerciseCycle get currentCycle => realisedTraining.cycles[currentCycleIndex];

  RealisedExercise get currentExo => currentCycle.exercises[currentExoIndex];

  ReferenceExercise get currentRefExo => currentExo.exerciseReference;

  ExerciseSet get currentSet => currentExo.sets[currentSetIndex];

  ExerciseCycle get currentRefTrainingCycle =>
      referenceTraining.cycles[currentCycleIndex];

  RealisedExercise get currentRefTrainingExo =>
      currentRefTrainingCycle.exercises[currentExoIndex];

  ReferenceExercise get currentRefTrainingRefExo =>
      currentRefTrainingExo.exerciseReference;

  ExerciseSet get currentRefTrainingSet =>
      currentRefTrainingExo.sets[currentSetIndex];

  int get nextSetIndex {
    int len = currentExo.sets.length;
    if (currentSetIndex + 1 < len) {
      return currentSetIndex + 1;
    }
    return 0;
  }

  int? get nextExoIndex {
    int nextSetIndex = this.nextSetIndex;
    // Changing exercise
    if (nextSetIndex == 0) {
      int cycleLength = referenceTraining.cycles.length;
      int exerciseLength = currentCycle.exercises.length;
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
      int cycleLength = referenceTraining.cycles.length;
      int exerciseLength = currentCycle.exercises.length;
      int currentExoIndex = this.currentExoIndex;
      // Has next exo in cycle
      if (currentExoIndex + 1 < exerciseLength) {
        return currentCycle.exercises[currentExoIndex + 1];
      }
      // loop to first exo in cycle
      if (currentCycleIndex + 1 < cycleLength) {
        return referenceTraining.cycles[currentCycleIndex + 1].exercises[0];
      }
      return null;
    }
    return currentExo;
  }

  @override
  List<Object?> get props => [
        referenceTraining,
        realisedTraining,
        currentCycleIndex,
        currentExoIndex,
        currentSetIndex,
        isEnd,
        realisedTrainingId,
        elapsedTime,
        currentView,
        reallyDoneReps
      ];

  InWorkoutState copyWith(
          {Training? referenceTraining,
          Training? realisedTraining,
          int? currentCycleIndex,
          int? elapsedTime,
          int? currentExoIndex,
          int? currentSetIndex,
          int? realisedTrainingId,
          int? reallyDoneReps,
          double? reallyUsedWeight,
          InWorkoutView? currentView,
          bool? isEnd}) =>
      InWorkoutState(
          isEnd: isEnd ?? this.isEnd,
          referenceTraining: referenceTraining ?? this.referenceTraining,
          elapsedTime: elapsedTime ?? this.elapsedTime,
          currentView: currentView ?? this.currentView,
          realisedTraining: realisedTraining ?? this.realisedTraining,
          currentCycleIndex: currentCycleIndex ?? this.currentCycleIndex,
          currentExoIndex: currentExoIndex ?? this.currentExoIndex,
          currentSetIndex: currentSetIndex ?? this.currentSetIndex,
          realisedTrainingId: realisedTrainingId ?? this.realisedTrainingId,
          reallyDoneReps: reallyDoneReps ?? this.reallyDoneReps);
}
