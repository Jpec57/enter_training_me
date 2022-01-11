// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferenceExercise _$ReferenceExerciseFromJson(Map<String, dynamic> json) =>
    ReferenceExercise(
      id: json['id'] as int?,
      name: json['name'] as String,
      reference: json['reference'] as String? ?? "B1",
      material: (json['material'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isBodyweightExercise: json['isBodyweightExercise'] as bool? ?? false,
      isOnlyIsometric: json['isOnlyIsometric'] as bool? ?? false,
      muscleActivations: (json['muscleActivations'] as List<dynamic>?)
              ?.map((e) => MuscleActivation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      strainessFactor: (json['strainessFactor'] as num?)?.toDouble() ?? 0.5,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ReferenceExerciseToJson(ReferenceExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reference': instance.reference,
      'description': instance.description,
      'strainessFactor': instance.strainessFactor,
      'isBodyweightExercise': instance.isBodyweightExercise,
      'isOnlyIsometric': instance.isOnlyIsometric,
      'material': instance.material,
      'muscleActivations': instance.muscleActivations,
    };
