import 'package:enter_training_me/models/exercise_cycle.dart';
import 'package:enter_training_me/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

@JsonSerializable()
class Training {
  final int? id;
  final String name;
  final User? author;
  final List<ExerciseCycle> cycles;
  final int restBetweenCycles;
  final int? estimatedTimeInSeconds;
  final bool isOfficial;

  const Training(
      {required this.name,
      required this.cycles,
      this.author,
      this.id,
      this.isOfficial = false,
      this.estimatedTimeInSeconds,
      required this.restBetweenCycles});

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);

  factory Training.clone(Training ref) {
    return Training(
        name: ref.name,
        author: ref.author,
        isOfficial: false,
        restBetweenCycles: ref.restBetweenCycles,
        cycles: ref.cycles);
  }
  @override
  String toString() {
    return "Training $name [$cycles]";
  }

  Training copyWith({
    List<ExerciseCycle>? cycles,
    int? restBetweenCycles,
    User? author,
    String? name,
  }) =>
      Training(
          restBetweenCycles: restBetweenCycles ?? this.restBetweenCycles,
          cycles: cycles ?? this.cycles,
          name: name ?? this.name,
          author: author ?? this.author);
}
