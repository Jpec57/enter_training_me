import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realised_exercise.g.dart';

@JsonSerializable()
class RealisedExercise {
  final List<ExerciseSet> sets;
  final ReferenceExercise exerciseReference;
  final int restBetweenSet;
  final ExecutionStyle? executionStyle;

  const RealisedExercise({required this.exerciseReference,
    required this.sets,
    required this.restBetweenSet,
    this.executionStyle,

  });

  factory RealisedExercise.fromJson(Map<String, dynamic> json) => _$RealisedExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$RealisedExerciseToJson(this);
}