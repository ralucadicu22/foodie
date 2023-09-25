import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RestaurantInfoWidget extends StatelessWidget {
  final RestaurantDetailed restaurant;

  RestaurantInfoWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Call',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              Text(restaurant.displayPhoneDetailed,
                  style: TextStyle(fontSize: 15, color: AppColors.black)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cuisines',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                restaurant.categoriesDetailed.toString(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Average Cost',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                restaurant.priceDetailed,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
