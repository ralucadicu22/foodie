// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/bloc/get_details/bloc/get_details_bloc.dart';
import 'package:restaurant_app/map.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/models/star_rating.dart';
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
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(state.restaurant!.image_url),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHome(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              state.restaurant!.name,
                              style: TextStyle(
                                fontSize: 25,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                            state.restaurant!.id);
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
                                  launchUrlString(state.restaurant!.url);
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
                              Column(
                                children: [
                                  Text(
                                    ' ${state.restaurant!.location.address1}, ${state.restaurant!.location.city}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    '${state.restaurant!.location.state}, ${state.restaurant!.location.country}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.restaurant!.categories.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  for (var openHours
                                      in state.restaurant!.hours[0].open)
                                    Text(
                                      '${openHours.start} - ${openHours.end}',
                                    ),
                                ],
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 160,
                                  color: AppColors.lightblue,
                                  child: RestaurantMap(
                                    lat: state.restaurant!.coordinates.latitude
                                        .toDouble(),
                                    long: state
                                        .restaurant!.coordinates.longitude
                                        .toDouble(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Call',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 18),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        launchUrlString(
                                            state.restaurant!.display_phone);
                                      },
                                      child: Text(
                                        state.restaurant!.display_phone,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cuisines',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 18),
                                    ),
                                    Text(
                                      state.restaurant!.categories.toString(),
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Average Cost',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 18),
                                    ),
                                    Text(
                                      state.restaurant!.price,
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
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
                                    itemCount: state.restaurant!.photos.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 110,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              state.restaurant!.photos[index],
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
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  'Reviews',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: state.reviews!.map((review) {
                              String shortText = review.text.substring(0, 20);
                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              review.user.image_url),
                                        ),
                                        VerticalDivider(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.user.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                StarRating(
                                                    rating: review.rating
                                                        .toDouble()),
                                                SizedBox(width: 5),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 15),
                                    child: Text(
                                      review.expanded ? review.text : shortText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<GetDetailsBloc>(context)
                                          .add(
                                        ReadMoreReviews(review: review),
                                      );
                                    },
                                    child: Text(
                                      review.expanded
                                          ? 'Read Less'
                                          : 'Read More',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
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
