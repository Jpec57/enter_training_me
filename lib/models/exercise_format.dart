import 'package:ctraining/models/execution_style.dart';
import 'package:ctraining/models/exercise_set.dart';
import 'package:ctraining/models/realised_exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_format.g.dart';

@JsonSerializable()
class ExerciseFormat {
  final List<ExerciseSet> predefinedSets;
  final int predefinedRest;
  final ExecutionStyle executionStyle;

  const ExerciseFormat({required this.predefinedSets, required this.predefinedRest, required this.executionStyle});

  factory ExerciseFormat.fromJson(Map<String, dynamic> json) => _$ExerciseFormatFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseFormatToJson(this);
}