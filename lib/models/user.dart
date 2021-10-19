import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements IAuthUserInterface {
  final int id;
  final String username;
  @override
  final String email;

  const User({required this.id, required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
