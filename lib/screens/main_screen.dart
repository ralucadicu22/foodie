// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/location/location_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/navigation_bar.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/screens/home_screen.dart';

class MyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc()..add(FetchLocation()),
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.state == LocationStateEnum.denied) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Location access denied!'),
                ),
              );
            });
          } else if (state.state == LocationStateEnum.granted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomeScreen()),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi, nice to meet you!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Set your location to start exploring',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        'restaurants around you',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.color2,
                          minimumSize: Size(300, 40),
                        ),
                        onPressed: () {
                          BlocProvider.of<LocationBloc>(context)
                              .add(RequestLocation());
                        },
                        child: Text(
                          'Use current location',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
