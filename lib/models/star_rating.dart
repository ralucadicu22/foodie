import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double maxRating = 5;
  StarRating({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(
          children: List.generate(
              maxRating.toInt(),
              (i) => Icon(
                    (i < rating.floor()
                        ? Icons.star
                        : (i == rating.floor() && rating % 1 > 0
                            ? Icons.star_half
                            : Icons.star_border)),
                    color: AppColors.color2,
                  ))),
      SizedBox(width: 5),
      Text(
        '$rating / $maxRating',
        style: TextStyle(fontSize: 16, color: AppColors.color2),
      ),
    ]);
  }
}
