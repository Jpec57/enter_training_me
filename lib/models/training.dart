import 'package:enter_training_me/models/exercise_comparision_dto.dart';
import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/muscle_activation.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/models/user.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

String? trainingRefToJson(Training? ref) {
  if (ref == null) {
    return null;
  }
  return "api/trainings/${ref.id!}";
}

@JsonSerializable()
class Training {
  final int? id;
  final DateTime? createdDate;
  final String name;
  final User? author;
  final List<ExerciseCycle> cycles;
  final int restBetweenCycles;
  final int? estimatedTimeInSeconds;
  final bool isOfficial;
  @JsonKey(toJson: trainingRefToJson)
  final Training? reference;

  const Training(
      {required this.name,
      required this.cycles,
      this.author,
      this.id,
      this.createdDate,
      this.isOfficial = false,
      this.reference,
      this.estimatedTimeInSeconds,
      required this.restBetweenCycles});

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);

  factory Training.clone(Training ref) {
    return Training(
        name: ref.name,
        author: ref.author,
        isOfficial: false,
        reference: ref,
        restBetweenCycles: ref.restBetweenCycles,
        cycles: ref.cycles);
  }
  @override
  String toString() {
    return "Training $name [$cycles]";
  }

  int get intensity {
    return exercisesAsFlatList
        .map((e) => e.intensity)
        .reduce((value, element) => value + element)
        .floor();
  }

  Map<String, double> get focusRepartition {
    List<RealisedExercise> exos = exercisesAsFlatList;
    int setLength = 0;
    const goalHypertrophy = "HYPERTROPHY";
    const goalStrength = "STRENGTH";
    const goalEndurance = "ENDURANCE";
    const goalExplosivity = "EXPLOSIVITY";
    Map<String, double> map = {
      goalHypertrophy: 0,
      goalStrength: 0,
      goalEndurance: 0,
      goalExplosivity: 0,
    };
    for (RealisedExercise exo in exos) {
      if (exo.executionStyle != null) {
        switch (exo.executionStyle!.name) {
          default:
            print(exo.executionStyle!.name);
            map[goalExplosivity] = 1 + (map[goalExplosivity] ?? 0);
            break;
        }
      } else {
        for (var element in exo.sets) {
          if (element.reps <= 6) {
            map[goalStrength] = 1 + (map[goalStrength] ?? 0);
          } else if (element.reps <= 12) {
            map[goalHypertrophy] = 1 + (map[goalHypertrophy] ?? 0);
          } else {
            map[goalEndurance] = 1 + (map[goalEndurance] ?? 0);
          }
        }
      }

      setLength += exo.sets.length;
    }
    for (var key in map.keys) {
      map[key] = map[key]! / setLength;
    }
    return map;
  }

  List<MuscleActivation> get muscleRepartition {
    List<RealisedExercise> exos = exercisesAsFlatList;
    int length = exos.length;
    Map<String, double> map = {};
    for (RealisedExercise exo in exos) {
      List<MuscleActivation>? activations =
          exo.exerciseReference.muscleActivations;
      if (activations != null) {
        for (var activation in activations) {
          if (map.containsKey(activation.muscle)) {
            map[activation.muscle] =
                activation.activationRatio + map[activation.muscle]!;
          } else {
            map[activation.muscle] = activation.activationRatio;
          }
        }
      }
    }
    return map.entries
        .map((e) =>
            MuscleActivation(muscle: e.key, activationRatio: e.value / length))
        .toList();
  }

  List<RealisedExercise> get exercisesAsFlatList {
    List<RealisedExercise> realisedExercises = [];

    for (var i = 0; i < cycles.length; i++) {
      var currentCycle = cycles[i];
      for (var j = 0; j < currentCycle.exercises.length; j++) {
        var currentExo = currentCycle.exercises[j];
        realisedExercises.add(currentExo);
      }
    }
    return realisedExercises;
  }

  List<ExerciseComparisionDTO> getExerciseComparisionsList(
      Training? referenceTraining) {
    List<ExerciseComparisionDTO> list = [];

    int k = 0;

    for (var i = 0; i < cycles.length; i++) {
      var currentCycle = cycles[i];
      var refCycle =
          (referenceTraining != null && i < referenceTraining.cycles.length)
              ? referenceTraining.cycles[i]
              : null;
      for (var j = 0; j < currentCycle.exercises.length; j++) {
        var currentExo = currentCycle.exercises[j];
        var refExo = (refCycle != null && j < refCycle.exercises.length)
            ? refCycle.exercises[j]
            : null;
        list.add(ExerciseComparisionDTO(
            index: k, realisedExercise: currentExo, referenceExercise: refExo));
        k++;
      }
    }
    return list;
  }

  Training copyWith({
    List<ExerciseCycle>? cycles,
    int? restBetweenCycles,
    User? author,
    String? name,
  }) =>
      Training(
          restBetweenCycles: restBetweenCycles ?? this.restBetweenCycles,
          cycles: cycles ?? this.cycles,
          name: name ?? this.name,
          reference: reference,
          author: author ?? this.author);
}
