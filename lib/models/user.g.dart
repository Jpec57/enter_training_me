// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      fitnessTeam: json['fitnessTeam'] == null
          ? null
          : FitnessTeam.fromJson(json['fitnessTeam'] as Map<String, dynamic>),
      isMale: json['isMale'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      fitnessProfile: json['fitnessProfile'] == null
          ? null
          : FitnessProfile.fromJson(
              json['fitnessProfile'] as Map<String, dynamic>),
      profilePicturePath: json['profilePicturePath'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'profilePicturePath': instance.profilePicturePath,
      'isMale': instance.isMale,
      'createdAt': instance.createdAt.toIso8601String(),
      'fitnessProfile': instance.fitnessProfile,
      'fitnessTeam': instance.fitnessTeam,
    };
