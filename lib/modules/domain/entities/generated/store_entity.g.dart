// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../store_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreEntityAdapter extends TypeAdapter<StoreEntity> {
  @override
  final int typeId = 2;

  @override
  StoreEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreEntity(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
