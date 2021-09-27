import 'package:ctraining/models/realised_exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

@JsonSerializable()
class ExerciseSet {
  final int reps;
  final double? weightPercent;
  final double? weight;

  const ExerciseSet({required this.reps, this.weightPercent, required this.weight});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) => _$ExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);
}