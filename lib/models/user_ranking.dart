import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_ranking.g.dart';

@JsonSerializable()
class UserRanking {
  final User user;
  final int experience;

  const UserRanking({required this.user, required this.experience});

  factory UserRanking.fromJson(Map<String, dynamic> json) =>
      _$UserRankingFromJson(json);
  Map<String, dynamic> toJson() => _$UserRankingToJson(this);
}
