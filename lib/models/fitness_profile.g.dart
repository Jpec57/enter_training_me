// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessProfile _$FitnessProfileFromJson(Map<String, dynamic> json) =>
    FitnessProfile(
      experience: json['experience'] as int,
      age: json['age'] as int,
      weight: (json['weight'] as num).toDouble(),
      badges: (json['badges'] as List<dynamic>)
          .map((e) => FitnessBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      hamstringExperience: json['hamstringExperience'] as int? ?? 0,
      quadricepsExperience: json['quadricepsExperience'] as int? ?? 0,
      calfExperience: json['calfExperience'] as int? ?? 0,
      bicepsExperience: json['bicepsExperience'] as int? ?? 0,
      tricepsExperience: json['tricepsExperience'] as int? ?? 0,
      shoulderExperience: json['shoulderExperience'] as int? ?? 0,
      chestExperience: json['chestExperience'] as int? ?? 0,
      absExperience: json['absExperience'] as int? ?? 0,
      backExperience: json['backExperience'] as int? ?? 0,
      forearmExperience: json['forearmExperience'] as int? ?? 0,
      goals: (json['goals'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FitnessProfileToJson(FitnessProfile instance) =>
    <String, dynamic>{
      'experience': instance.experience,
      'age': instance.age,
      'weight': instance.weight,
      'goals': instance.goals,
      'badges': instance.badges,
      'hamstringExperience': instance.hamstringExperience,
      'quadricepsExperience': instance.quadricepsExperience,
      'calfExperience': instance.calfExperience,
      'absExperience': instance.absExperience,
      'forearmExperience': instance.forearmExperience,
      'bicepsExperience': instance.bicepsExperience,
      'tricepsExperience': instance.tricepsExperience,
      'shoulderExperience': instance.shoulderExperience,
      'chestExperience': instance.chestExperience,
      'backExperience': instance.backExperience,
    };
