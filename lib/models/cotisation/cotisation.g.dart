// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cotisation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CotisationAdapter extends TypeAdapter<Cotisation> {
  @override
  final int typeId = 4;

  @override
  Cotisation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cotisation(
      currentAmount: fields[1] as double,
      targetAmount: fields[2] as double,
      user: fields[3] as User,
    );
  }

  @override
  void write(BinaryWriter writer, Cotisation obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.currentAmount)
      ..writeByte(2)
      ..write(obj.targetAmount)
      ..writeByte(3)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CotisationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
