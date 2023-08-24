import 'package:hive/hive.dart';
import 'package:restaurant_app/models/location_data_model.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 0)
class RestaurantHive extends HiveObject {
  @HiveField(0)
  final LocationData location;

  @HiveField(1)
  final String image_url;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String display_phone;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final List<String> categories;

  @HiveField(6)
  final String id;

  RestaurantHive({
    required this.location,
    required this.id,
    required this.image_url,
    required this.title,
    required this.display_phone,
    required this.rating,
    required this.categories,
  });
}

class Restaurant {
  final LocationData location;
  final String id;
  final String image_url;
  final String title;
  final String display_phone;
  final double rating;
  final List<String> categories;

  Restaurant({
    required this.location,
    required this.id,
    required this.image_url,
    required this.title,
    required this.display_phone,
    required this.rating,
    required this.categories,
  });

  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
      location: LocationData.fromJson(json['location']),
      image_url: json['image_url'] ?? '',
      title: json['name'] ?? '',
      display_phone: json['display_phone'] ?? '',
      rating: json['rating'] ?? 0.0,
      id: json['id'] ?? '',
      categories: (json['categories'] as List)
          .map((e) => e['title'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location,
        'image_url': image_url,
        'title': title,
        'display_phone': display_phone,
        'rating': rating,
        'categories': categories,
        'id': id,
      };
}

Restaurant convertHiveToRestaurant(RestaurantHive hiveData) {
  return Restaurant(
    location: hiveData.location,
    id: hiveData.id,
    image_url: hiveData.image_url,
    title: hiveData.title,
    display_phone: hiveData.display_phone,
    rating: hiveData.rating,
    categories: hiveData.categories,
  );
}
