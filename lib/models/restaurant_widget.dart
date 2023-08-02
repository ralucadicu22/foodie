import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant model;
  RestaurantWidget(this.model);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(model.image_url),
            fit: BoxFit.cover,
          )),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: AppColors.black.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      model.location,
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                )))
      ],
    );
  }
}
