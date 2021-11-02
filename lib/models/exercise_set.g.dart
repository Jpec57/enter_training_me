// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => ExerciseSet(
      reps: json['reps'] as int,
      weightPercent: (json['weightPercent'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      realisedDate: json['realisedDate'] == null
          ? null
          : DateTime.parse(json['realisedDate'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseSetToJson(ExerciseSet instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'weightPercent': instance.weightPercent,
      'weight': instance.weight,
      'realisedDate': instance.realisedDate?.toIso8601String(),
      'user': instance.user,
    };
