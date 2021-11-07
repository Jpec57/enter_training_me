import 'package:enter_training_me/models/exercise_comparision_dto.dart';
import 'package:enter_training_me/models/muscle_activation.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

String? trainingRefToJson(Training? ref) {
  if (ref == null) {
    return null;
  }
  return "api/trainings/${ref.id!}";
}

@JsonSerializable()
class Training extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final User? author;
  final List<RealisedExercise> exercises;
  final int restBetweenCycles;
  final int numberOfLoops;
  final int? estimatedTimeInSeconds;
  final bool isOfficial;
  final double intensity;
  final String? difficulty;
  @JsonKey(toJson: trainingRefToJson)
  final Training? reference;

  const Training(
      {required this.name,
      required this.exercises,
      this.numberOfLoops = 1,
      this.author,
      this.id,
      this.difficulty,
      this.createdAt,
      this.updatedAt,
      this.isOfficial = false,
      this.reference,
      required this.intensity,
      this.estimatedTimeInSeconds,
      this.restBetweenCycles = 60});

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);

  Map<String, dynamic> toJsonForCreation() {
    Map<String, dynamic> json = _$TrainingToJson(this);
    return cleanForCreation(json);
  }

  static Map<String, dynamic> cleanForCreation(Map<String, dynamic> json) {
    //TODO in API
    json.remove('author');
    json.remove("id");
    json.remove("createdAt");
    json['isOfficial'] = false;
    return json;
  }

  factory Training.clone(Training? ref) {
    if (ref == null) {
      return Training(
          name: "Tmp training",
          isOfficial: false,
          createdAt: DateTime.now(),
          reference: ref,
          intensity: 0,
          numberOfLoops: 1,
          restBetweenCycles: 60,
          exercises: const []);
    }
    return Training(
        name: ref.name,
        numberOfLoops: ref.numberOfLoops,
        author: ref.author,
        isOfficial: false,
        createdAt: ref.createdAt,
        reference: ref,
        intensity: ref.intensity,
        restBetweenCycles: ref.restBetweenCycles,
        exercises: ref.exercises);
  }
  @override
  String toString() {
    return "Training $id $name [$exercises]";
  }

  List<String> get materials {
    List<String> materials = [];
    for (var exo in exercises) {
      for (var mat in exo.exerciseReference.material) {
        if (!materials.contains(mat)) {
          materials.add(mat);
        }
      }
    }
    return materials;
  }

  double get sumOfUsedWeight {
    double sum = 0;
    for (var exo in exercises) {
      double setWeight = 0;
      int setLength = exo.sets.length;
      if (setLength > 0) {
        for (var set in exo.sets) {
          setWeight += (set.weight) ?? 0;
        }
        sum += (setWeight);
      }
    }
    return sum;
  }

  double get sumOfUsedAvgWeight {
    double sum = 0;
    for (var exo in exercises) {
      double setWeight = 0;
      int setLength = exo.sets.length;
      if (setLength > 0) {
        for (var set in exo.sets) {
          setWeight += (set.weight) ?? 0;
        }
        sum += (setWeight / setLength);
      }
    }
    return sum;
  }

  double get sumOfAvgRMWeight {
    double sum = 0;
    for (var exo in exercises) {
      double setWeight = 0;
      int setLength = exo.sets.length;
      if (setLength > 0) {
        for (var set in exo.sets) {
          setWeight += (set.estimated1RM);
        }
        sum += (setWeight / setLength);
      }
    }
    return sum;
  }

  Map<String, double> get focusRepartition {
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
    for (RealisedExercise exo in exercises) {
      if (false && exo.executionStyle != null) {
        switch (exo.executionStyle!.name) {
          default:
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
    List<RealisedExercise> exos = exercises;
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

  List<ExerciseComparisionDTO> getExerciseComparisionsList(
      Training? referenceTraining) {
    List<ExerciseComparisionDTO> list = [];

    int k = 0;

    for (var j = 0; j < exercises.length; j++) {
      var currentExo = exercises[j];
      var refExo =
          referenceTraining != null ? referenceTraining.exercises[j] : null;
      list.add(ExerciseComparisionDTO(
          index: k, realisedExercise: currentExo, referenceExercise: refExo));
      k++;
    }
    return list;
  }

  Training copyWith({
    List<RealisedExercise>? exercises,
    int? restBetweenCycles,
    User? author,
    int? numberOfLoops,
    String? name,
  }) =>
      Training(
          id: id,
          numberOfLoops: numberOfLoops ?? this.numberOfLoops,
          restBetweenCycles: restBetweenCycles ?? this.restBetweenCycles,
          exercises: exercises ?? this.exercises,
          name: name ?? this.name,
          reference: reference,
          isOfficial: isOfficial,
          intensity: intensity,
          createdAt: createdAt,
          author: author ?? this.author);

  @override
  List<Object?> get props => [
        id,
        exercises,
        numberOfLoops,
        updatedAt,
        name,
        author,
        restBetweenCycles,
        estimatedTimeInSeconds,
        isOfficial,
        reference
      ];
}
