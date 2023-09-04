import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/location.dart';

class RestaurantMapModel {
  final CoordinatesMap coordinatesMap;
  final String nameMap;
  final String idMap;
  final CLocation locationMap;
  final List<String> categoriesMap;
  final String imageUrlMap;
  final double ratingMap;

  RestaurantMapModel(
      {required this.coordinatesMap,
      required this.nameMap,
      required this.idMap,
      required this.locationMap,
      required this.categoriesMap,
      required this.imageUrlMap,
      required this.ratingMap});
  static RestaurantMapModel fromJson(Map<String, dynamic> json) {
    return RestaurantMapModel(
        coordinatesMap: CoordinatesMap.fromJson(json['coordinates']),
        nameMap: json['name'] ?? '',
        idMap: json['id'] ?? '',
        locationMap: CLocation.fromJson(json['location']),
        categoriesMap: (json['categories'] as List)
            .map((e) => e['title'] as String)
            .toList(),
        imageUrlMap: json['image_url'] ?? '',
        ratingMap: json['rating'] ?? 0.0);
  }

  Map<String, dynamic> toJson() => {
        'coordinates': coordinatesMap,
        'name': nameMap,
        'id': idMap,
        'location': locationMap,
        'categories': categoriesMap,
        'image_url': imageUrlMap,
        'rating': ratingMap
      };
}

class CoordinatesMap {
  final double longitude;
  final double latitude;
  CoordinatesMap({required this.latitude, required this.longitude});
  static CoordinatesMap fromJson(Map<String, dynamic> json) {
    return CoordinatesMap(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}
