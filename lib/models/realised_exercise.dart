import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realised_exercise.g.dart';

String? exerciseRefToJson(ReferenceExercise? ref) {
  if (ref?.id == null) {
    return null;
  }
  return "api/exercise_references/${ref!.id}";
}

String? executionStyleToJson(ExecutionStyle? style) {
  if (style?.id == null) {
    return null;
  }
  return "api/execution_styles/${style!.id}";
}

@JsonSerializable()
class RealisedExercise extends Equatable {
  // final int? id;
  final List<ExerciseSet> sets;
  @JsonKey(toJson: exerciseRefToJson)
  final ReferenceExercise exerciseReference;
  final int restBetweenSet;
  @JsonKey(toJson: executionStyleToJson)
  final ExecutionStyle? executionStyle;
  final bool isIsometric;

  const RealisedExercise({
    // this.id,
    required this.exerciseReference,
    required this.sets,
    required this.restBetweenSet,
    this.isIsometric = false,
    this.executionStyle,
  });

  factory RealisedExercise.fromJson(Map<String, dynamic> json) {
    return _$RealisedExerciseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$RealisedExerciseToJson(this);
  Map<String, dynamic> toJsonForCreation() => _$RealisedExerciseToJson(this);

  RealisedExercise copyWith(
          {List<ExerciseSet>? sets,
          ReferenceExercise? exerciseReference,
          int? restBetweenSet}) =>
      RealisedExercise(
          exerciseReference: exerciseReference ?? this.exerciseReference,
          executionStyle: executionStyle,
          restBetweenSet: restBetweenSet ?? this.restBetweenSet,
          isIsometric: isIsometric,
          sets: sets ?? this.sets);

  @override
  String toString() {
    return "$exerciseReference (Rest: $restBetweenSet Execution: $executionStyle, sets $sets)";
  }

  /// Estimate exercise intensity with the following assumptions:
  /// - restTime
  /// - weightPercent
  /// - nbSets
  ///  - exerciseDifficulty
  ///  - executionStyle
  ///  - isBodyweight
  double get intensity {
    int setNb = sets.length;
    double difficulty = 0.5;
    double intensity = 0;
    for (var set in sets) {
      intensity += (1 + (set.weight ?? 70)) * set.reps;
    }

    return intensity * difficulty;
  }

  double get maxEstimated1RMInSet {
    double max = 0;
    for (var set in sets) {
      var rm = set.estimated1RM;
      if (max < rm) {
        max = rm;
      }
    }

    return max;
  }

  @override
  List<Object?> get props => [
        sets,
        executionStyle,
        exerciseReference,
        restBetweenSet,
        isIsometric,
      ];
}
