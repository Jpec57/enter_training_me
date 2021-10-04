import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_cycle.g.dart';

@JsonSerializable()
class ExerciseCycle {
  final List<RealisedExercise> exercises;
  final int restBetweenLoop;
  final int numberOfLoops;

  const ExerciseCycle(
      {required this.exercises,
      required this.numberOfLoops,
      required this.restBetweenLoop});

  factory ExerciseCycle.fromJson(Map<String, dynamic> json) =>
      _$ExerciseCycleFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseCycleToJson(this);

  @override
  String toString() {
    return "ExerciseCycle($numberOfLoops with $restBetweenLoop) [$exercises]";
  }
}
