import 'package:json_annotation/json_annotation.dart';
part 'fitness_team.g.dart';

@JsonSerializable()
class FitnessTeam {
  final String name;
  final String? logo;
  final String? banner;
  final int experience;

  const FitnessTeam(
      {required this.name, this.logo, this.banner, required this.experience});

  factory FitnessTeam.fromJson(Map<String, dynamic> json) =>
      _$FitnessTeamFromJson(json);
  Map<String, dynamic> toJson() => _$FitnessTeamToJson(this);
}
