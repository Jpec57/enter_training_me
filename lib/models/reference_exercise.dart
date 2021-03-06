import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reference_exercise.g.dart';

@JsonSerializable()
class ReferenceExercise {
  final int? id;
  final String name;
  final String reference;
  final String? description;
  final double strainessFactor;
  final bool isBodyweightExercise;
  final bool isOnlyIsometric;
  final List<String> material;
  final List<MuscleActivation>? muscleActivations;

  const ReferenceExercise(
      {this.id,
      required this.name,
      this.reference = "B1",
      this.material = const [],
      this.isBodyweightExercise = false,
      this.isOnlyIsometric = false,
      this.muscleActivations = const [],
      this.strainessFactor = 0.5,
      this.description});

  String get shortName {
    if (name.length < 12) {
      return name;
    }
    var re = RegExp(r" |-");
    List<String> words = name.split(re);
    return words
        .map((w) => w.length > 3 ? w.substring(0, 3) : w)
        .toList()
        .join(". ");
  }

  factory ReferenceExercise.fromJson(Map<String, dynamic> json) =>
      _$ReferenceExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceExerciseToJson(this);

  @override
  String toString() {
    return "RefExo: $name";
  }
}
