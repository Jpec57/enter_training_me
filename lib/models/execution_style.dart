import 'package:json_annotation/json_annotation.dart';

part 'execution_style.g.dart';

@JsonSerializable()
class ExecutionStyle {
  final String name;
  final String? description;
  final double strainFactor;

  const ExecutionStyle({required this.name, this.description, required this.strainFactor});

  factory ExecutionStyle.fromJson(Map<String, dynamic> json) => _$ExecutionStyleFromJson(json);
  Map<String, dynamic> toJson() => _$ExecutionStyleToJson(this);
}