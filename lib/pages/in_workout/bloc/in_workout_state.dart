part of 'in_workout_bloc.dart';

class InWorkoutState extends Equatable {
  final Training referenceTraining;
  final Training realisedTraining;
  final int currentCycleIndex;
  final int currentExoIndex;
  final int currentSetIndex;
  final bool isEnd;

  const InWorkoutState({
    required this.referenceTraining,
    required this.realisedTraining,
    this.isEnd = false,
    this.currentCycleIndex = 0,
    this.currentExoIndex = 0,
    this.currentSetIndex = 0,
  });

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
        isEnd
      ];

  InWorkoutState copyWith(
          {Training? referenceTraining,
          Training? realisedTraining,
          int? currentCycleIndex,
          int? currentExoIndex,
          int? currentSetIndex,
          bool? isEnd}) =>
      InWorkoutState(
        isEnd: isEnd ?? this.isEnd,
        referenceTraining: referenceTraining ?? this.referenceTraining,
        realisedTraining: realisedTraining ?? this.realisedTraining,
        currentCycleIndex: currentCycleIndex ?? this.currentCycleIndex,
        currentExoIndex: currentExoIndex ?? this.currentExoIndex,
        currentSetIndex: currentSetIndex ?? this.currentSetIndex,
      );
}
