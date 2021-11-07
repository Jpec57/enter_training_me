import 'package:json_annotation/json_annotation.dart';
part 'fitness_badge.g.dart';

@JsonSerializable()
class FitnessBadge {
  final String name;
  final String? imagePath;
  final String description;

  const FitnessBadge(
      {required this.name, this.imagePath, required this.description});

  factory FitnessBadge.fromJson(Map<String, dynamic> json) =>
      _$FitnessBadgeFromJson(json);
  Map<String, dynamic> toJson() => _$FitnessBadgeToJson(this);
}
