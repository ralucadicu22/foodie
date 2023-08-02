import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

class Restaurant {
  late String location;
  late String image_url;
  late String title;
  Restaurant(this.location, this.image_url, this.title);
  Restaurant.fromJson(Map<String, dynamic> json) {
    location = json['location'] ?? '';
    image_url = json['image_url'] ?? '';
    title = json['title'] ?? '';

    Map<String, dynamic> toJson() => {
          'location': location,
          'image_url': image_url,
          'title': title,
        };
  }
}
