import 'package:json_annotation/json_annotation.dart';

part 'reference_exercise.g.dart';

@JsonSerializable()
class ReferenceExercise {
  final String name;
  final String reference;
  final String? description;

  const ReferenceExercise({required this.name, required this.reference,  this.description});

  factory ReferenceExercise.fromJson(Map<String, dynamic> json) => _$ReferenceExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceExerciseToJson(this);
}