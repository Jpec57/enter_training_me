// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRanking _$UserRankingFromJson(Map<String, dynamic> json) => UserRanking(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      experience: json['experience'] as int,
    );

Map<String, dynamic> _$UserRankingToJson(UserRanking instance) =>
    <String, dynamic>{
      'user': instance.user,
      'experience': instance.experience,
    };
