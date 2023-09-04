import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';

class ContactInfoWidget extends StatelessWidget {
  final RestaurantDetailed restaurant;

  ContactInfoWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${restaurant.locationDetailed.address}, ${restaurant.locationDetailed.city}',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.black,
          ),
        ),
        Text(
          '${restaurant.locationDetailed.state}, ${restaurant.locationDetailed.country}',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          restaurant.categoriesDetailed.toString(),
          style: TextStyle(
            fontSize: 15,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        for (var openHours in restaurant.hoursDetailed[0].open)
          Text(
            '${openHours.start} - ${openHours.end}',
          ),
      ],
    );
  }
}
