// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/location_bloc.dart';
import 'package:restaurant_app/colors.dart';

class MyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state.state == LocationStateEnum.granted) {
        //  Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => HomeScreen()),
        //   );
        return Container(color: Colors.pink);
      } else if (state.state == LocationStateEnum.denied) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location access denied!'),
            ),
          );
        });
      }

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
                          .add(FetchLocation());
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.black,
                  ),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon:
                      Icon(Icons.location_on_outlined, color: AppColors.black),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border_outlined,
                      color: AppColors.black),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: AppColors.black,
                  ),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }));
  }
}
