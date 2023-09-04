import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/models/location_data_model.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

Future<void> dataBase(Restaurant restaurant) async {
  var restaurantBox = await Hive.box<Restaurant>('restaurantBox');
  await restaurantBox.add(restaurant);
  final restaurants = restaurantBox.values.toList();
}

class RestaurantAdapter extends TypeAdapter<Restaurant> {
  @override
  final typeId = 0;

  @override
  Restaurant read(BinaryReader reader) {
    final map = reader.readMap();
    return Restaurant(
      location: map['location'] as LocationDataModel,
      id: map['id'] as String,
      image_url: map['image_url'] as String,
      title: map['title'] as String,
      display_phone: map['display_phone'] as String,
      rating: map['rating'] as double,
      categories: (map['categories'] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Restaurant restaurant) {
    writer.writeMap({
      'location': restaurant.location,
      'id': restaurant.id,
      'image_url': restaurant.image_url,
      'title': restaurant.title,
      'display_phone': restaurant.display_phone,
      'rating': restaurant.rating,
      'categories': restaurant.categories,
    });
  }
}

class LocationDataAdapter extends TypeAdapter<LocationDataModel> {
  @override
  final typeId = 1;

  @override
  LocationDataModel read(BinaryReader reader) {
    final address1 = reader.readString();
    return LocationDataModel(address1: address1);
  }

  @override
  void write(BinaryWriter writer, LocationDataModel locationData) {
    writer.writeString(locationData.address1);
  }
}
