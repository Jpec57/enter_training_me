// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_workout_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InWorkoutState _$InWorkoutStateFromJson(Map<String, dynamic> json) =>
    InWorkoutState(
      referenceTrainingId: json['referenceTrainingId'] as int?,
      realisedTraining:
          Training.fromJson(json['realisedTraining'] as Map<String, dynamic>),
      isEnd: json['isEnd'] as bool? ?? false,
      elapsedTime: json['elapsedTime'] as int? ?? 0,
      changes: json['changes'] as Map<String, dynamic>? ?? const {},
      realisedTrainingId: json['realisedTrainingId'] as int?,
      currentCycleIndex: json['currentCycleIndex'] as int? ?? 0,
      currentExoIndex: json['currentExoIndex'] as int? ?? 0,
      currentView:
          _$enumDecodeNullable(_$InWorkoutViewEnumMap, json['currentView']) ??
              InWorkoutView.inExerciseView,
      currentSetIndex: json['currentSetIndex'] as int? ?? 0,
      reallyDoneReps: json['reallyDoneReps'] as int? ?? 0,
    );

Map<String, dynamic> _$InWorkoutStateToJson(InWorkoutState instance) =>
    <String, dynamic>{
      'referenceTrainingId': instance.referenceTrainingId,
      'realisedTraining': instance.realisedTraining,
      'currentCycleIndex': instance.currentCycleIndex,
      'currentExoIndex': instance.currentExoIndex,
      'currentSetIndex': instance.currentSetIndex,
      'elapsedTime': instance.elapsedTime,
      'reallyDoneReps': instance.reallyDoneReps,
      'realisedTrainingId': instance.realisedTrainingId,
      'isEnd': instance.isEnd,
      'currentView': _$InWorkoutViewEnumMap[instance.currentView],
      'changes': instance.changes,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$InWorkoutViewEnumMap = {
  InWorkoutView.inExerciseView: 'inExerciseView',
  InWorkoutView.inRestView: 'inRestView',
  InWorkoutView.endWorkoutView: 'endWorkoutView',
  InWorkoutView.newExerciseView: 'newExerciseView',
};
