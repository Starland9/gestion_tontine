// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reunion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReunionAdapter extends TypeAdapter<Reunion> {
  @override
  final int typeId = 5;

  @override
  Reunion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reunion(
      cause: fields[1] as String,
      date: fields[2] as DateTime,
      participants: (fields[3] as List).cast<User>(),
    );
  }

  @override
  void write(BinaryWriter writer, Reunion obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.cause)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.participants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReunionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
