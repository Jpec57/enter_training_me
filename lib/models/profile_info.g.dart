// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) => ProfileInfo(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      trainingCount: json['trainingCount'] as int,
      sbdSum: (json['sbdSum'] as num?)?.toDouble() ?? 762.3,
      globalRank: json['globalRank'] as int? ?? 1,
      lastTrainings: (json['lastTrainings'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'user': instance.user,
      'trainingCount': instance.trainingCount,
      'globalRank': instance.globalRank,
      'sbdSum': instance.sbdSum,
      'lastTrainings': instance.lastTrainings,
    };
