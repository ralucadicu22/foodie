// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

import 'package:restaurant_app/screens/favorites_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/models.dart';

class ListContainer extends StatelessWidget {
  final Restaurant model;
  final bool showImage;

  const ListContainer(this.model, {this.showImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 120,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.grey, width: 1)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showImage)
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.image_url),
                  ),
                ),
              ),
            Column(
              children: [
                Text(
                  model.display_phone,
                  style: TextStyle(color: AppColors.grey, fontSize: 15),
                ),
                SizedBox(height: 5),
                Text(
                  model.title,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  model.location.address1,
                  style: TextStyle(color: AppColors.grey, fontSize: 15),
                ),
                SizedBox(height: 5),
                Text(
                  model.categories.join(', '),
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 60,
                  height: 20,
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
                SizedBox(height: 25),
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    final isFavorite = state.favorites
                        .any((restaurant) => restaurant.id == model.id);

                    return ElevatedButton.icon(
                      onPressed: () {
                        if (isFavorite) {
                          BlocProvider.of<FavoritesBloc>(context)
                              .add(RemoveFromFavorites(model));
                        } else {
                          BlocProvider.of<FavoritesBloc>(context)
                              .add(AddToFavorites(model));
                        }
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color:
                            isFavorite ? AppColors.pink : AppColors.lightblue,
                      ),
                      label: Text(''),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        alignment: Alignment.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
