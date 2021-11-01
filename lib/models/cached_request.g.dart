// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedRequestAdapter extends TypeAdapter<CachedRequest> {
  @override
  final int typeId = 0;

  @override
  CachedRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedRequest(
      fields[0] as DateTime,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CachedRequest obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.savedDate)
      ..writeByte(1)
      ..write(obj.string);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
