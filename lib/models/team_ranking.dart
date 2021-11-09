import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_ranking.g.dart';

@JsonSerializable()
class TeamRanking {
  final FitnessTeam team;
  final int experience;

  const TeamRanking({required this.team, required this.experience});

  factory TeamRanking.fromJson(Map<String, dynamic> json) =>
      _$TeamRankingFromJson(json);
  Map<String, dynamic> toJson() => _$TeamRankingToJson(this);
}
