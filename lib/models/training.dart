import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

@JsonSerializable()
class Training {
  final String name;
  final User? author;
  final List<ExerciseCycle> cycles;
  final int restBetweenCycles;

  const Training({required this.name, required this.cycles, this.author, required this.restBetweenCycles});

  factory Training.fromJson(Map<String, dynamic> json) => _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}