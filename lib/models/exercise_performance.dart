import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_performance.g.dart';

@JsonSerializable()
class ExercisePerformance {
  final double max;
  final List<ExerciseSet> sets;
  final User user;

  const ExercisePerformance(
      {required this.user, this.max = 0, this.sets = const []});

  factory ExercisePerformance.fromJson(Map<String, dynamic> json) =>
      _$ExercisePerformanceFromJson(json);
  Map<String, dynamic> toJson() => _$ExercisePerformanceToJson(this);
}
