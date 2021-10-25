import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_cycle.g.dart';

@JsonSerializable()
class ExerciseCycle extends Equatable {
  // final int? id;
  final List<RealisedExercise> exercises;
  final int restBetweenLoop;
  final int numberOfLoops;

  const ExerciseCycle({
    required this.exercises,
    this.numberOfLoops = 1,
    this.restBetweenLoop = 60,
    // this.id
  });

  factory ExerciseCycle.fromJson(Map<String, dynamic> json) =>
      _$ExerciseCycleFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseCycleToJson(this);

  @override
  String toString() {
    return "ExerciseCycle($numberOfLoops with $restBetweenLoop) [$exercises]";
  }

  ExerciseCycle copyWith({List<RealisedExercise>? exercises}) => ExerciseCycle(
      exercises: exercises ?? this.exercises,
      numberOfLoops: numberOfLoops,
      restBetweenLoop: restBetweenLoop);

  @override
  List<Object?> get props => [exercises, numberOfLoops, restBetweenLoop];
}
