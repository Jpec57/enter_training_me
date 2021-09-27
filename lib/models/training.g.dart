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
      restBetweenCycles: json['restBetweenCycles'] as int,
    );

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'name': instance.name,
      'author': instance.author,
      'cycles': instance.cycles,
      'restBetweenCycles': instance.restBetweenCycles,
    };
