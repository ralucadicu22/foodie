import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/location_data_model.dart';

class Restaurant {
  late LocationData location;
  late String image_url;
  late String title;
  Restaurant(this.location, this.image_url, this.title);
  Restaurant.fromJson(Map<String, dynamic> json) {
    location = LocationData.fromJson(json['location']);
    image_url = json['image_url'] ?? '';
    title = json['name'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'location': location,
        'image_url': image_url,
        'title': title,
      };
}
