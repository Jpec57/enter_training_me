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
  final Map<String, dynamic> changes;

  final int reallyDoneReps;

  const InWorkoutState(
      {this.referenceTrainingId,
      required this.realisedTraining,
      this.isEnd = false,
      this.elapsedTime = 0,
      this.changes = const {},
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
    if (realisedTraining.exercises.isEmpty) {
      return 100;
    }
    List<RealisedExercise> exos = realisedTraining.exercises;
    if (exos.isEmpty) {
      return 100;
    }
    for (var exo in exos) {
      setPerCycle += exo.sets.length;
    }
    totalSets = realisedTraining.numberOfLoops * setPerCycle;
    //Total set END

    int totalCurrentCycleDoneSets = 0;
    for (int i = 0; i < currentExoIndex; i++) {
      totalCurrentCycleDoneSets += exos[i].sets.length;
    }
    totalCurrentCycleDoneSets += currentSetIndex;

    bool hasDoneCurrentSet = currentView == InWorkoutView.inRestView;
    totalDoneSets = (currentCycleIndex * setPerCycle) +
        totalCurrentCycleDoneSets +
        (hasDoneCurrentSet ? 1 : 0);

    return totalDoneSets.toDouble() / totalSets;
  }

  bool get isEndOfWorkout => nextExoIndex == null;
  bool get isNewWorkout => referenceTrainingId == null;

  RealisedExercise? get currentExo =>
      currentExoIndex < realisedTraining.exercises.length
          ? realisedTraining.exercises[currentExoIndex]
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

  int? get nextCycleIndex {
    int? nextExoIndex = this.nextExoIndex;
    if (nextExoIndex == null) {
      return null;
    }
    if (nextExoIndex == 0 && nextSetIndex == 0) {
      return currentCycleIndex + 1;
    }
    return currentCycleIndex;
  }

  int? get nextExoIndex {
    int nextSetIndex = this.nextSetIndex;
    // Changing exercise
    if (nextSetIndex == 0) {
      int cycleLength = realisedTraining.numberOfLoops;
      int exerciseLength = realisedTraining.exercises.length;
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
      int cycleLength = realisedTraining.numberOfLoops;
      int exerciseLength = realisedTraining.exercises.length;
      int currentExoIndex = this.currentExoIndex;
      // Has next exo in cycle
      if (currentExoIndex + 1 < exerciseLength) {
        return realisedTraining.exercises[currentExoIndex + 1];
      }
      // loop to first exo in cycle
      if (currentCycleIndex + 1 < cycleLength) {
        return realisedTraining.exercises[0];
      }
      return null;
    }
    return currentExo;
  }

  List<InWorkoutView> getNonTickingViews() => [
        InWorkoutView.endWorkoutView,
        //  InWorkoutView.newExerciseView
      ];

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
        changes,
      ];

  InWorkoutState copyWith(
          {int? referenceTrainingId,
          Training? realisedTraining,
          int? currentCycleIndex,
          int? elapsedTime,
          Map<String, dynamic>? changes,
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
          changes: changes ?? this.changes,
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
