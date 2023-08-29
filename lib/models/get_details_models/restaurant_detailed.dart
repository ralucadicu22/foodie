import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/get_details_models/coordinates.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/location.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

class RestaurantDetailed {
  final String name;
  final String id;
  final String image_url;
  final List<String> categories;
  final String price;
  final CLocation location;
  final String display_phone;
  final List<Hours> hours;
  final List<String> photos;
  final CustomCoordinates coordinates;

  final String url;

  RestaurantDetailed(
      {required this.name,
      required this.id,
      required this.image_url,
      required this.categories,
      required this.price,
      required this.display_phone,
      required this.hours,
      required this.photos,
      required this.url,
      required this.coordinates,
      required this.location});
  static RestaurantDetailed fromJson(Map<String, dynamic> json) {
    return RestaurantDetailed(
        name: json['name'] ?? '',
        id: json['id'] ?? '',
        image_url: json['image_url'] ?? '',
        categories: (json['categories'] as List)
            .map((e) => e['title'] as String)
            .toList(),
        price: json['price'] ?? '',
        location: CLocation.fromJson(json['location']),
        display_phone: json['display_phone'] ?? '',
        hours: (json['hours'] as List)
            .map((hoursJson) => Hours.fromJson(hoursJson))
            .toList(),
        photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
        url: json['url'] ?? '',
        coordinates: CustomCoordinates.fromJson(json['coordinates']));
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'image_url': image_url,
        'categories': categories,
        'price': price,
        'display_phone': display_phone,
        'hours': hours,
        'photos': photos,
        'url': url,
        'location': location,
        'coordinates': coordinates,
      };
}
