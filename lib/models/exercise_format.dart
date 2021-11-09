import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/models/exercise_set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_format.g.dart';

@JsonSerializable()
class ExerciseFormat {
  final int id;
  final List<ExerciseSet> predefinedSets;
  final int predefinedRest;
  final ExecutionStyle executionStyle;

  const ExerciseFormat(
      {required this.id,
      required this.predefinedSets,
      required this.predefinedRest,
      required this.executionStyle});

  factory ExerciseFormat.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFormatFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseFormatToJson(this);
}
