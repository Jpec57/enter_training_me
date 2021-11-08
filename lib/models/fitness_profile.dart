import 'package:enter_training_me/models/fitness_badge.dart';
import 'package:enter_training_me/models/muscle_experience.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fitness_profile.g.dart';

@JsonSerializable()
class FitnessProfile {
  final int experience;
  final int age;
  final double weight;
  final List<String> goals;
  final List<FitnessBadge> badges;
  final int hamstringExperience;
  final int quadricepsExperience;
  final int calfExperience;
  final int absExperience;
  final int forearmExperience;
  final int bicepsExperience;
  final int tricepsExperience;
  final int shoulderExperience;
  final int chestExperience;
  final int backExperience;

  const FitnessProfile(
      {required this.experience,
      required this.age,
      required this.weight,
      required this.badges,
      this.hamstringExperience = 0,
      this.quadricepsExperience = 0,
      this.calfExperience = 0,
      this.bicepsExperience = 0,
      this.tricepsExperience = 0,
      this.shoulderExperience = 0,
      this.chestExperience = 0,
      this.absExperience = 0,
      this.backExperience = 0,
      this.forearmExperience = 0,
      required this.goals});

  factory FitnessProfile.fromJson(Map<String, dynamic> json) =>
      _$FitnessProfileFromJson(json);
  Map<String, dynamic> toJson() => _$FitnessProfileToJson(this);

  List<MuscleExperience> get muscleExperiences {
    return [
      MuscleExperience(muscle: "hamstring", experience: hamstringExperience),
      MuscleExperience(muscle: "quadriceps", experience: quadricepsExperience),
      MuscleExperience(muscle: "calf", experience: calfExperience),
      MuscleExperience(muscle: "biceps", experience: bicepsExperience),
      MuscleExperience(muscle: "triceps", experience: tricepsExperience),
      MuscleExperience(muscle: "shoulder", experience: shoulderExperience),
      MuscleExperience(muscle: "chest", experience: chestExperience),
      MuscleExperience(muscle: "abs", experience: absExperience),
      MuscleExperience(muscle: "back", experience: backExperience),
      MuscleExperience(muscle: "forearm", experience: forearmExperience),
    ];
  }
}
