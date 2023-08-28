import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

class RestaurantDetailed {
  final String name;
  final String id;
  final String image_url;
  final List<String> categories;
  final String price;
  final List<String> location;
  final String display_phone;
  final List<Hours> hours;
  final List<String> photos;
  final List<Review> reviews;
  final double latitude;
  final double longitude;
  final String url;

  RestaurantDetailed(
      {required this.name,
      required this.id,
      required this.image_url,
      required this.categories,
      required this.price,
      required this.location,
      required this.display_phone,
      required this.hours,
      required this.photos,
      required this.reviews,
      required this.latitude,
      required this.longitude,
      required this.url});
  static RestaurantDetailed fromJson(Map<String, dynamic> json) {
    return RestaurantDetailed(
        name: json['name'] ?? '',
        id: json['id'] ?? '',
        image_url: json['image_url'] ?? '',
        categories: (json['categories'] as List)
            .map((e) => e['title'] as String)
            .toList(),
        price: json['price'] ?? '',
        location: (json['location'] as List)
            .map((e) => e['address1'] as String)
            .toList(),
        display_phone: json['display_phone'] ?? '',
        hours: (json['hours'] as List)
            .map((hoursJson) => Hours.fromJson(hoursJson))
            .toList(),
        photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
        reviews: (json['reviews'] as List)
            .map((reviewJson) => Review.fromJson(reviewJson))
            .toList(),
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'image_url': image_url,
        'categories': categories,
        'price': price,
        'location': location,
        'display_phone': display_phone,
        'hours': hours,
        'photos': photos,
        'reviews': reviews,
        'latitude': latitude,
        'longitude': longitude,
        'url': url,
      };
}
