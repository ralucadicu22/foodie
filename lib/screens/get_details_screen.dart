// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/get_details/bloc/get_details_bloc.dart';
import 'package:restaurant_app/map.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/hours.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/favorites_screen.dart';
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
            return ListView(scrollDirection: Axis.vertical, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 500,
                    color: AppColors.grey,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomeScreen(),
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
                            style:
                                TextStyle(fontSize: 25, color: AppColors.white),
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
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    color: AppColors.lightblue,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Favorites',
                                    style: TextStyle(color: AppColors.black),
                                  ),
                                ],
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
                          children: [
                            Column(
                              children: [
                                Text(state.restaurant!.location.toString()),
                                Text(state.restaurant!.categories.toString()),
                                Text(state.restaurant!.hours.toString()),
                              ],
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                  height: 160,
                                  color: AppColors.lightblue,
                                  child: RestaurantMap(
                                    lat: state.restaurant!.latitude,
                                    long: state.restaurant!.longitude,
                                  )),
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
                                        color: AppColors.grey, fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launchUrlString(
                                          state.restaurant!.display_phone);
                                    },
                                    child: Text(''),
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
                                    'Cuisines',
                                    style: TextStyle(
                                        color: AppColors.grey, fontSize: 18),
                                  ),
                                  Text(state.restaurant!.categories.toString()),
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
                                        color: AppColors.grey, fontSize: 18),
                                  ),
                                  Text(state.restaurant!.price)
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Photos',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                color: AppColors.color3,
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                color: AppColors.color3,
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                color: AppColors.color3,
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                color: AppColors.color3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: state.reviews!.map((review) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.color2,
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(review.user.image_url),
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
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            review.rating.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.black),
                                          ),
                                        ],
                                      ),
                                      VerticalDivider(
                                        width: 100,
                                      ),
                                      Column(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.person_add_alt_outlined,
                                              color: AppColors.black,
                                            ),
                                            label: Text(''),
                                          ),
                                          Row(
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: AppColors.color2,
                                                ),
                                                label: Text(''),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.comment_outlined,
                                                  color: AppColors.black,
                                                ),
                                                label: Text(''),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(review.text),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
