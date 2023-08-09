import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/location_data_model.dart';

class Restaurant {
  final LocationData location;
  final String image_url;
  final String title;
  final String display_phone;
  final double rating;
  final List<String> categories;
  Restaurant(
      {required this.location,
      this.image_url = '',
      required this.title,
      required this.display_phone,
      required this.rating,
      required this.categories});
  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
        location: LocationData.fromJson(json['location']),
        image_url: json['image_url'] ?? '',
        title: json['name'] ?? '',
        display_phone: json['display_phone'] ?? '',
        rating: json['rating'] ?? '',
        categories: (json['categories'] as List)
            .map((e) => e['title'] as String)
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'location': location,
        'image_url': image_url,
        'title': title,
        'display_phone': display_phone,
        'rating': rating,
        'categories': categories,
      };
}
