// import 'dart:async';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/splash/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/screens/intro_screen.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/screens/main_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashBloc()..add(StartLoadingEvent()),
        child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.state == SplashScreenState.loaded) {
                if (state.redirect == PageRedirect.firstTime) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyIntro()),
                  );
                }
                if (state.redirect == PageRedirect.home) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyMain()),
                  );
                }
                if (state.redirect == PageRedirect.login) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.color1,
              appBar: AppBar(
                backgroundColor: AppColors.color2,
                title: Text(
                  'DISCOVER YOUR FOOD',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.dining_outlined,
                      size: 150.0,
                      color: AppColors.white,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.color1,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  ),
                  Text(
                    'Choose the food you LOVE ',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )));
  }
}
