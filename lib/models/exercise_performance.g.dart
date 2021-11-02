// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePerformance _$ExercisePerformanceFromJson(Map<String, dynamic> json) =>
    ExercisePerformance(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      max: (json['max'] as num?)?.toDouble() ?? 0,
      sets: (json['sets'] as List<dynamic>?)
              ?.map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExercisePerformanceToJson(
        ExercisePerformance instance) =>
    <String, dynamic>{
      'max': instance.max,
      'sets': instance.sets,
      'user': instance.user,
    };
