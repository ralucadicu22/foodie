import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double maxRating = 5;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 0; i < maxRating; i++) {
      if (i < rating.floor()) {
        stars.add(Icon(
          Icons.star,
          color: AppColors.color2,
        ));
      } else if (i == rating.floor() && rating % 1 > 0) {
        stars.add(Icon(
          Icons.star_half,
          color: AppColors.color2,
        ));
      } else {
        stars.add(Icon(
          Icons.star_border,
          color: AppColors.color2,
        ));
      }
    }

    return Row(children: [
      Row(children: stars),
      SizedBox(width: 5),
      Text(
        '$rating / $maxRating',
        style: TextStyle(fontSize: 16, color: AppColors.color2),
      ),
    ]);
  }
}
