import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/restaurant_map.dart';
import 'package:restaurant_app/screens/get_details_screen.dart';

class ContainerMap extends StatelessWidget {
  final RestaurantMapModel restaurantMapModel;
  final String id;
  ContainerMap({required this.restaurantMapModel, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyDetails(
              id: restaurantMapModel.idMap,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurantMapModel.imageUrlMap),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantMapModel.nameMap,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    '${restaurantMapModel.locationMap.address}, ${restaurantMapModel.locationMap.city}',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    '${restaurantMapModel.locationMap.country}, ${restaurantMapModel.locationMap.state}',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.color1,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: Text(
                    restaurantMapModel.ratingMap.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
