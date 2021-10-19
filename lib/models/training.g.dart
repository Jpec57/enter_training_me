// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Training _$TrainingFromJson(Map<String, dynamic> json) => Training(
      name: json['name'] as String,
      cycles: (json['cycles'] as List<dynamic>)
          .map((e) => ExerciseCycle.fromJson(e as Map<String, dynamic>))
          .toList(),
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      id: json['id'] as int?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      isOfficial: json['isOfficial'] as bool? ?? false,
      reference: json['reference'] == null
          ? null
          : Training.fromJson(json['reference'] as Map<String, dynamic>),
      estimatedTimeInSeconds: json['estimatedTimeInSeconds'] as int?,
      restBetweenCycles: json['restBetweenCycles'] as int,
    );

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate?.toIso8601String(),
      'name': instance.name,
      'author': instance.author,
      'cycles': instance.cycles,
      'restBetweenCycles': instance.restBetweenCycles,
      'estimatedTimeInSeconds': instance.estimatedTimeInSeconds,
      'isOfficial': instance.isOfficial,
      'reference': trainingRefToJson(instance.reference),
    };
