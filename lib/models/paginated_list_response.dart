import 'package:json_annotation/json_annotation.dart';

part 'paginated_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedListResponse<T> {
  final List<T> entities;
  final bool hasNext;
  final bool hasPrevious;

  const PaginatedListResponse(
      {required this.entities,
      required this.hasNext,
      required this.hasPrevious});

  factory PaginatedListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginatedListResponseFromJson(json, fromJsonT);

  @override
  String toString() {
    return "(hasNext $hasNext hasPrevious $hasPrevious entities count ${entities.length})";
  }
}
