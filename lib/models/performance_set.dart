import 'package:enter_training_me/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_set.g.dart';

double stringToDouble(String? str) {
  if (str == null) {
    return 0;
  }
  return double.parse(str);
}

@JsonSerializable()
class PerformanceSet extends Equatable {
  final ExerciseSet set;
  @JsonKey(fromJson: stringToDouble)
  final double estimatedOneRM;

  const PerformanceSet({
    required this.set,
    required this.estimatedOneRM,
  });

  factory PerformanceSet.fromJson(Map<String, dynamic> json) =>
      _$PerformanceSetFromJson(json);
  Map<String, dynamic> toJson() => _$PerformanceSetToJson(this);

  @override
  List<Object?> get props => [set, estimatedOneRM];
}
