import 'package:flutter/material.dart';
import 'package:restaurant_app/models/get_details_models/user.dart';

class Review {
  final String idReview;
  final String textReview;
  final int ratingReview;
  final User userReview;
  final String timeCreatedReview;
  bool expanded;
  Review({
    required this.idReview,
    required this.textReview,
    required this.ratingReview,
    required this.userReview,
    required this.timeCreatedReview,
    this.expanded = false,
  });

  Review copyWith({bool? expanded}) {
    return Review(
      idReview: this.idReview,
      textReview: this.textReview,
      ratingReview: this.ratingReview,
      userReview: this.userReview,
      timeCreatedReview: this.timeCreatedReview,
      expanded: expanded ?? this.expanded,
    );
  }

  static Review fromJson(Map<String, dynamic> json) {
    return Review(
        idReview: json['id'] ?? '',
        textReview: json['text'] ?? '',
        ratingReview: (json['rating']) ?? 0,
        userReview: User.fromJson(json['user']),
        timeCreatedReview: json['time_created'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': idReview,
        'text': textReview,
        'rating': ratingReview,
        'user': userReview,
        'time_created': timeCreatedReview
      };
}
