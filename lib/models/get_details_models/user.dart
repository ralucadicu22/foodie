import 'package:flutter/material.dart';

class User {
  final String idUser;
  final String imageUrlUser;
  final String nameUser;
  User(
      {required this.idUser,
      required this.imageUrlUser,
      required this.nameUser});
  static User fromJson(Map<String, dynamic> json) {
    return User(
        idUser: json['id'] ?? '',
        imageUrlUser: json['image_url'] ?? '',
        nameUser: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': idUser,
        'image_url': imageUrlUser,
        'name': nameUser,
      };
}
