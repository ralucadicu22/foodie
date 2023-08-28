import 'package:flutter/material.dart';

class User {
  final String id;
  final String image_url;
  final String name;
  User({required this.id, required this.image_url, required this.name});
  static User fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] ?? '',
        image_url: json['image_url'] ?? '',
        name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': image_url,
        'name': name,
      };
}
