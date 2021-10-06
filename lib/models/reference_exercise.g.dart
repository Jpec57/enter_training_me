// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferenceExercise _$ReferenceExerciseFromJson(Map<String, dynamic> json) =>
    ReferenceExercise(
      id: json['id'] as int,
      name: json['name'] as String,
      reference: json['reference'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ReferenceExerciseToJson(ReferenceExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reference': instance.reference,
      'description': instance.description,
    };
