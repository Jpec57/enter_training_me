// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseCycle _$ExerciseCycleFromJson(Map<String, dynamic> json) =>
    ExerciseCycle(
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => RealisedExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfLoops: json['numberOfLoops'] as int,
      restBetweenLoop: json['restBetweenLoop'] as int,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ExerciseCycleToJson(ExerciseCycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exercises': instance.exercises,
      'restBetweenLoop': instance.restBetweenLoop,
      'numberOfLoops': instance.numberOfLoops,
    };
