// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRanking _$TeamRankingFromJson(Map<String, dynamic> json) => TeamRanking(
      team: FitnessTeam.fromJson(json['team'] as Map<String, dynamic>),
      experience: json['experience'] as int,
    );

Map<String, dynamic> _$TeamRankingToJson(TeamRanking instance) =>
    <String, dynamic>{
      'team': instance.team,
      'experience': instance.experience,
    };
