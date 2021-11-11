import 'package:enter_training_me/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_info.g.dart';

@JsonSerializable()
class ProfileInfo {
  final User user;
  final int trainingCount;
  final int globalRank;
  final double sbdSum;
  final List<Training> lastTrainings;

  ProfileInfo(
      {required this.user,
      required this.trainingCount,
      this.sbdSum = 762.3,
      this.globalRank = 1,
      required this.lastTrainings});

  ProfileInfo copyWith({User? user}) => ProfileInfo(
      user: user ?? this.user,
      trainingCount: trainingCount,
      lastTrainings: lastTrainings);

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}
