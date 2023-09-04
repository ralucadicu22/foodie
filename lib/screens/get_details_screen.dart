// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/bloc/get_details/bloc/get_details_bloc.dart';
import 'package:restaurant_app/map.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/contact_infos.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_infos.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';
import 'package:restaurant_app/models/get_details_models/reviews_section.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/models/star_rating.dart';
import 'package:restaurant_app/models/get_details_models/top_bar.dart';
import 'package:restaurant_app/screens/favorites_screen.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyDetails extends StatelessWidget {
  final String id;
  MyDetails({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDetailsBloc(id: id)..add(FetchDetails(id: id)),
      child: GetDetails(),
    );
  }
}

class GetDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color3,
      body: BlocBuilder<GetDetailsBloc, GetDetailsState>(
        builder: (context, state) {
          if (state.state == GetDetailsScreenState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == GetDetailsScreenState.loaded) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopBarWidget(
                        imageUrl: state.restaurant!.imageUrlDetailed,
                        name: state.restaurant!.nameDetailed),
                    SizedBox(height: 20),
                    Text(
                      'Order Food Online',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      color: AppColors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.ios_share,
                                      color: AppColors.black,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Share',
                                      style: TextStyle(color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FavoritesScreen(),
                                    ),
                                  );
                                },
                                child:
                                    BlocBuilder<FavoritesBloc, FavoritesState>(
                                  builder: (context, favoritesState) {
                                    final isFavorite = favoritesState.favorites
                                        .any((restaurant) =>
                                            restaurant.id ==
                                            state.restaurant!.idDetailed);
                                    return Column(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          color: isFavorite
                                              ? AppColors.pink
                                              : AppColors.lightblue,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Favorites',
                                          style:
                                              TextStyle(color: AppColors.black),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  launchUrlString(
                                      state.restaurant!.urlDetailed);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.link,
                                      color: AppColors.black,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Photo URL',
                                      style: TextStyle(color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ContactInfoWidget(restaurant: state.restaurant!),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 160,
                                  color: AppColors.lightblue,
                                  child: RestaurantMap(
                                    lat: state.restaurant!.coordinatesDetailed
                                        .latitude
                                        .toDouble(),
                                    long: state.restaurant!.coordinatesDetailed
                                        .longitude
                                        .toDouble(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          RestaurantInfoWidget(restaurant: state.restaurant!),
                          Padding(
                            padding: EdgeInsets.only(right: 15, left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Photos',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.restaurant!.photosDetailed.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 110,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              state.restaurant!
                                                  .photosDetailed[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ReviewsSection(reviews: state.reviews!),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
