import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:enter_training_me/models/models.dart';
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
class RealisedExercise {
  // final int? id;
  final List<ExerciseSet> sets;
  //TODO
  @JsonKey(toJson: exerciseRefToJson)
  final ReferenceExercise exerciseReference;
  final int restBetweenSet;
  //TODO
  @JsonKey(toJson: executionStyleToJson)
  final ExecutionStyle? executionStyle;

  const RealisedExercise({
    // this.id,
    required this.exerciseReference,
    required this.sets,
    required this.restBetweenSet,
    this.executionStyle,
  });

  factory RealisedExercise.fromJson(Map<String, dynamic> json) =>
      _$RealisedExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$RealisedExerciseToJson(this);
  Map<String, dynamic> toJsonForCreation() => _$RealisedExerciseToJson(this);

  RealisedExercise copyWith({List<ExerciseSet>? sets}) => RealisedExercise(
      exerciseReference: exerciseReference,
      executionStyle: executionStyle,
      restBetweenSet: restBetweenSet,
      sets: sets ?? this.sets);

  @override
  String toString() {
    return "$exerciseReference (sets $sets)";
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
}
