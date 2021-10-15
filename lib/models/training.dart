import 'package:enter_training_me/models/exercise_comparision_dto.dart';
import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/models/user.dart';
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
