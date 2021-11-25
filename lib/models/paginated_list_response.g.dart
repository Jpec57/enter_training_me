// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedListResponse<T> _$PaginatedListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedListResponse<T>(
      entities: (json['entities'] as List<dynamic>).map(fromJsonT).toList(),
      hasNext: json['hasNext'] as bool,
      hasPrevious: json['hasPrevious'] as bool,
    );

Map<String, dynamic> _$PaginatedListResponseToJson<T>(
  PaginatedListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'entities': instance.entities.map(toJsonT).toList(),
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
    };
