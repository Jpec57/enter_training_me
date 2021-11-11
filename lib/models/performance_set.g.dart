// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceSet _$PerformanceSetFromJson(Map<String, dynamic> json) =>
    PerformanceSet(
      set: ExerciseSet.fromJson(json['set'] as Map<String, dynamic>),
      estimatedOneRM: stringToDouble(json['estimatedOneRM'] as String?),
    );

Map<String, dynamic> _$PerformanceSetToJson(PerformanceSet instance) =>
    <String, dynamic>{
      'set': instance.set,
      'estimatedOneRM': instance.estimatedOneRM,
    };
