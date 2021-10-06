// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExecutionStyle _$ExecutionStyleFromJson(Map<String, dynamic> json) =>
    ExecutionStyle(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      strainFactor: (json['strainFactor'] as num).toDouble(),
    );

Map<String, dynamic> _$ExecutionStyleToJson(ExecutionStyle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'strainFactor': instance.strainFactor,
    };
