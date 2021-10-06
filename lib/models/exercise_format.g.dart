// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseFormat _$ExerciseFormatFromJson(Map<String, dynamic> json) =>
    ExerciseFormat(
      id: json['id'] as int,
      predefinedSets: (json['predefinedSets'] as List<dynamic>)
          .map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      predefinedRest: json['predefinedRest'] as int,
      executionStyle: ExecutionStyle.fromJson(
          json['executionStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseFormatToJson(ExerciseFormat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'predefinedSets': instance.predefinedSets,
      'predefinedRest': instance.predefinedRest,
      'executionStyle': instance.executionStyle,
    };
