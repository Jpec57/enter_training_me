// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_activation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleActivation _$MuscleActivationFromJson(Map<String, dynamic> json) =>
    MuscleActivation(
      muscle: json['muscle'] as String,
      activationRatio: (json['activationRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$MuscleActivationToJson(MuscleActivation instance) =>
    <String, dynamic>{
      'muscle': instance.muscle,
      'activationRatio': instance.activationRatio,
    };
