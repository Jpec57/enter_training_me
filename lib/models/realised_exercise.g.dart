// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realised_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealisedExercise _$RealisedExerciseFromJson(Map<String, dynamic> json) =>
    RealisedExercise(
      exerciseReference: ReferenceExercise.fromJson(
          json['exerciseReference'] as Map<String, dynamic>),
      sets: (json['sets'] as List<dynamic>)
          .map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      restBetweenSet: json['restBetweenSet'] as int,
      isIsometric: json['isIsometric'] as bool? ?? false,
      executionStyle: json['executionStyle'] == null
          ? null
          : ExecutionStyle.fromJson(
              json['executionStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RealisedExerciseToJson(RealisedExercise instance) =>
    <String, dynamic>{
      'sets': instance.sets,
      'exerciseReference': exerciseRefToJson(instance.exerciseReference),
      'restBetweenSet': instance.restBetweenSet,
      'executionStyle': executionStyleToJson(instance.executionStyle),
      'isIsometric': instance.isIsometric,
    };
