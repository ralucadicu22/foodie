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
                    MaterialPageRoute(builder: (context) => MyLogin()),
                  );
                }
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.color1,
              appBar: AppBar(
                backgroundColor: AppColors.color2,
                title: Text(
                  'Discover your food',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.food_bank_outlined),
                    onPressed: () {},
                    color: AppColors.black,
                  )
                ],
                centerTitle: true,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppAssets.ass1,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        opacity: AlwaysStoppedAnimation(.7),
                      ),
                      Text(
                        'The secret of success in life is to eat what you like.',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 115,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.color2,
                        ),
                        child: Image.asset(AppAssets.ass2,
                            width: 150,
                            height: 115,
                            fit: BoxFit.cover,
                            opacity: AlwaysStoppedAnimation(.5)),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.transparent,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.start,
                        ),
                        label: Text('Get started'),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
