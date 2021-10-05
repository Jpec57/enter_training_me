part of 'in_workout_bloc.dart';

class InWorkoutState extends Equatable {
  final Training referenceTraining;
  final Training realisedTraining;
  final int currentCycleIndex;
  final int currentExoIndex;
  final int currentSetIndex;
  final bool isEnd;
  final int elapsedTime;

  const InWorkoutState({
    required this.referenceTraining,
    required this.realisedTraining,
    this.isEnd = false,
    this.elapsedTime = 0,
    this.currentCycleIndex = 0,
    this.currentExoIndex = 0,
    this.currentSetIndex = 0,
  });

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

  ExerciseCycle get currentCycle => referenceTraining.cycles[currentCycleIndex];

  RealisedExercise get currentExo => currentCycle.exercises[currentExoIndex];

  ReferenceExercise get currentRefExo =>
      currentCycle.exercises[currentExoIndex].exerciseReference;

  ExerciseSet get currentSet => currentExo.sets[currentSetIndex];

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
        elapsedTime
      ];

  InWorkoutState copyWith(
          {Training? referenceTraining,
          Training? realisedTraining,
          int? currentCycleIndex,
          int? elapsedTime,
          int? currentExoIndex,
          int? currentSetIndex,
          bool? isEnd}) =>
      InWorkoutState(
        isEnd: isEnd ?? this.isEnd,
        referenceTraining: referenceTraining ?? this.referenceTraining,
        elapsedTime: elapsedTime ?? this.elapsedTime,
        realisedTraining: realisedTraining ?? this.realisedTraining,
        currentCycleIndex: currentCycleIndex ?? this.currentCycleIndex,
        currentExoIndex: currentExoIndex ?? this.currentExoIndex,
        currentSetIndex: currentSetIndex ?? this.currentSetIndex,
      );
}
