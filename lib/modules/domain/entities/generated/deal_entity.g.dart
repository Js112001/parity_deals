// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../deal_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealEntityAdapter extends TypeAdapter<DealEntity> {
  @override
  final int typeId = 1;

  @override
  DealEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DealEntity(
      id: fields[0] as int?,
      commentsCount: fields[1] as int?,
      createdAt: fields[2] as DateTime?,
      createdAtInMillis: fields[3] as int?,
      imageMedium: fields[4] as String?,
      store: fields[5] as StoreEntity?,
      statusCode: fields[6] as int?,
      message: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DealEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentsCount)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.createdAtInMillis)
      ..writeByte(4)
      ..write(obj.imageMedium)
      ..writeByte(5)
      ..write(obj.store)
      ..writeByte(6)
      ..write(obj.statusCode)
      ..writeByte(7)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
