import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/get_details_models/coordinates.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/location.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

class RestaurantDetailed {
  final String nameDetailed;
  final String idDetailed;
  final String imageUrlDetailed;
  final List<String> categoriesDetailed;
  final String priceDetailed;
  final CLocation locationDetailed;
  final String displayPhoneDetailed;
  final List<Hours> hoursDetailed;
  final List<String> photosDetailed;
  final CustomCoordinates coordinatesDetailed;
  final String urlDetailed;

  RestaurantDetailed(
      {required this.nameDetailed,
      required this.idDetailed,
      required this.imageUrlDetailed,
      required this.categoriesDetailed,
      required this.priceDetailed,
      required this.displayPhoneDetailed,
      required this.hoursDetailed,
      required this.photosDetailed,
      required this.urlDetailed,
      required this.coordinatesDetailed,
      required this.locationDetailed});
  static RestaurantDetailed fromJson(Map<String, dynamic> json) {
    return RestaurantDetailed(
        nameDetailed: json['name'] ?? '',
        idDetailed: json['id'] ?? '',
        imageUrlDetailed: json['image_url'] ?? '',
        categoriesDetailed: (json['categories'] as List)
            .map((e) => e['title'] as String)
            .toList(),
        priceDetailed: json['price'] ?? '',
        locationDetailed: CLocation.fromJson(json['location']),
        displayPhoneDetailed: json['display_phone'] ?? '',
        hoursDetailed: (json['hours'] as List)
            .map((hoursJson) => Hours.fromJson(hoursJson))
            .toList(),
        photosDetailed:
            json['photos'] != null ? List<String>.from(json['photos']) : [],
        urlDetailed: json['url'] ?? '',
        coordinatesDetailed: CustomCoordinates.fromJson(json['coordinates']));
  }

  Map<String, dynamic> toJson() => {
        'name': nameDetailed,
        'id': idDetailed,
        'image_url': imageUrlDetailed,
        'categories': categoriesDetailed,
        'price': priceDetailed,
        'display_phone': displayPhoneDetailed,
        'hours': hoursDetailed,
        'photos': photosDetailed,
        'url': urlDetailed,
        'location': locationDetailed,
        'coordinates': coordinatesDetailed,
      };
}
