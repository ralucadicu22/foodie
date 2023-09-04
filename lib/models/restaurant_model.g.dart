// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantHiveAdapter extends TypeAdapter<RestaurantHive> {
  @override
  final int typeId = 0;

  @override
  RestaurantHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantHive(
      location: fields[0] as LocationDataModel,
      id: fields[6] as String,
      image_url: fields[1] as String,
      title: fields[2] as String,
      display_phone: fields[3] as String,
      rating: fields[4] as double,
      categories: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.image_url)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.display_phone)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
