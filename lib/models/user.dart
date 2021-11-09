import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';
import 'package:enter_training_me/models/fitness_profile.dart';
import 'package:enter_training_me/models/fitness_team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements IAuthUserInterface {
  final int id;
  final String username;
  @override
  final String email;
  final String? profilePicturePath;
  final bool isMale;
  final DateTime createdAt;
  final FitnessProfile? fitnessProfile;
  final FitnessTeam? fitnessTeam;

  const User(
      {required this.id,
      required this.username,
      required this.email,
      this.fitnessTeam,
      this.isMale = true,
      required this.createdAt,
      required this.fitnessProfile,
      this.profilePicturePath});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
