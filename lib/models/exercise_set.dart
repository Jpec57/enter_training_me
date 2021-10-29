import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

final List<double> rmPercents = [
  1,
  0.97,
  0.94,
  0.92,
  0.89,
  0.86,
  0.83,
  0.81,
  0.78,
  0.75,
  0.73,
  0.71,
  0.7,
  0.68,
  0.67,
  0.65,
  0.64,
  0.63,
  0.61,
  0.6
];

@JsonSerializable()
class ExerciseSet extends Equatable {
  final int reps;
  final double? weightPercent;
  final double? weight;

  const ExerciseSet(
      {required this.reps, this.weightPercent, required this.weight});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);

  ExerciseSet copyWith({
    int? reps,
    double? weightPercent,
    double? weight,
  }) =>
      ExerciseSet(
          reps: reps ?? this.reps,
          weight: weight ?? this.weight,
          weightPercent: weightPercent ?? this.weightPercent);

  String get str {
    return "$reps${weight != null && weight! > 0 ? "@${weight}kgs" : ""}";
  }

  @override
  String toString() {
    return "Set of $reps reps @${weight}kgs";
  }

  double get estimated1RM {
    int length = rmPercents.length;
    if (weight == null || weight == 0) {
      return 0;
    }
    if (reps < length) {
      return weight! / rmPercents[reps];
    }
    return weight! / rmPercents[length - 1];
  }

  @override
  List<Object?> get props => [reps, weight, weightPercent];
}
