import 'package:flutter/material.dart';
import 'package:restaurant_app/models/get_details_models/user.dart';

class Review {
  final String id;
  final String text;
  final int rating;
  final User user;
  final String time_created;
  bool expanded;
  Review({
    required this.id,
    required this.text,
    required this.rating,
    required this.user,
    required this.time_created,
    this.expanded = false,
  });

  Review copyWith({bool? expanded}) {
    return Review(
      id: this.id,
      text: this.text,
      rating: this.rating,
      user: this.user,
      time_created: this.time_created,
      expanded: expanded ?? this.expanded,
    );
  }

  static Review fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'] ?? '',
        text: json['text'] ?? '',
        rating: (json['rating']) ?? 0,
        user: User.fromJson(json['user']),
        time_created: json['time_created'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'rating': rating,
        'user': user,
        'time_created': time_created
      };
}
