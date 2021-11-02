import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_info.g.dart';

@JsonSerializable()
class ProfileInfo {
  final User user;
  final int trainingCount;
  final List<Training> lastTrainings;

  ProfileInfo(
      {required this.user,
      required this.trainingCount,
      required this.lastTrainings});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}
