import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

@JsonSerializable()
class ExerciseSet {
  final int reps;
  final double? weightPercent;
  final double? weight;

  const ExerciseSet(
      {required this.reps, this.weightPercent, required this.weight});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);

  ExerciseSet copyWith({
    int? reps,
    double? weightPercent,
    double? weight,
  }) =>
      ExerciseSet(
          reps: reps ?? this.reps,
          weight: weight ?? this.weight,
          weightPercent: weightPercent ?? this.weightPercent);

  @override
  String toString() {
    return "Set of $reps reps @${weight}kgs";
  }
}
