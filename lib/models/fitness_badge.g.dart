// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessBadge _$FitnessBadgeFromJson(Map<String, dynamic> json) => FitnessBadge(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      description: json['description'] as String,
    );

Map<String, dynamic> _$FitnessBadgeToJson(FitnessBadge instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'description': instance.description,
    };
