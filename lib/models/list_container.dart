// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/models.dart';

class ListContainer extends StatelessWidget {
  final Restaurant model;

  const ListContainer(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 120,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.grey, width: 1)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 5, top: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Text(
                model.display_phone,
                style: TextStyle(color: AppColors.grey, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                model.title,
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                model.location.address1,
                style: TextStyle(color: AppColors.grey, fontSize: 15),
              ),
              Text(
                model.categories.join(', '),
                style: TextStyle(color: AppColors.grey, fontSize: 15),
              )
            ],
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text(
                  model.rating.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: AppColors.lightblue,
                  ),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      alignment: Alignment.center))
            ],
          )
        ]),
      ),
    );
  }
}
