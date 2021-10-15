import 'package:json_annotation/json_annotation.dart';

part 'muscle_activation.g.dart';

@JsonSerializable()
class MuscleActivation {
  final String muscle;
  final double activationRatio;

  const MuscleActivation(
      {
      required this.muscle,
      required this.activationRatio});

  factory MuscleActivation.fromJson(Map<String, dynamic> json) =>
      _$MuscleActivationFromJson(json);
  Map<String, dynamic> toJson() => _$MuscleActivationToJson(this);
}
