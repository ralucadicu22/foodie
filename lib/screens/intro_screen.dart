// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/intro_bloc.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/login_screen.dart';
import 'models.dart';
import 'package:restaurant_app/dot.dart';

class MyIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroBloc(),
      child: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color3,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                BlocProvider.of<IntroBloc>(context)
                    .add(PageChangedEvent(index));
              },
              itemCount: models.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        models[i].image,
                        width: 250,
                        height: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        models[i].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        models[i].text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(300, 40),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          BlocBuilder<IntroBloc, IntroState>(
            builder: (context, state) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      models.length,
                      (index) => CustomeDot(index, state.currentIndex),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
