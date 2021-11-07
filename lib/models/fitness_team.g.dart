// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessTeam _$FitnessTeamFromJson(Map<String, dynamic> json) => FitnessTeam(
      name: json['name'] as String,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      experience: json['experience'] as int,
    );

Map<String, dynamic> _$FitnessTeamToJson(FitnessTeam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'logo': instance.logo,
      'banner': instance.banner,
      'experience': instance.experience,
    };
