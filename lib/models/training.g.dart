// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Training _$TrainingFromJson(Map<String, dynamic> json) => Training(
      name: json['name'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => RealisedExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfLoops: json['numberOfLoops'] as int? ?? 1,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      id: json['id'] as int?,
      difficulty: json['difficulty'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isOfficial: json['isOfficial'] as bool? ?? false,
      reference: json['reference'] == null
          ? null
          : Training.fromJson(json['reference'] as Map<String, dynamic>),
      intensity: (json['intensity'] as num).toDouble(),
      estimatedTimeInSeconds: json['estimatedTimeInSeconds'] as int?,
      restBetweenCycles: json['restBetweenCycles'] as int? ?? 60,
    );

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
      'author': instance.author,
      'exercises': instance.exercises,
      'restBetweenCycles': instance.restBetweenCycles,
      'numberOfLoops': instance.numberOfLoops,
      'estimatedTimeInSeconds': instance.estimatedTimeInSeconds,
      'isOfficial': instance.isOfficial,
      'intensity': instance.intensity,
      'difficulty': instance.difficulty,
      'reference': trainingRefToJson(instance.reference),
    };
