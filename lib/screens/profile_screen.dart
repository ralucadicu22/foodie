import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/dark_theme/bloc/dark_theme_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/bloc/logout/bloc/logout_bloc.dart';

import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(GetLoginData());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.color2,
                      )),
                  TextButton(onPressed: () {}, child: Text('Edit'))
                ]),
          ),
          SizedBox(
            height: 50,
          ),
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state.state == LoginScreenState.success) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(state.profileImage ?? ''),
                    backgroundColor: AppColors.color1,
                    radius: 60.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    state.userMailAddress ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
          SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invite friends',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                child: BlocListener<LogoutBloc, LogoutState>(
                  listener: (context, state) {
                    if (state.state == LogoutScreenState.loading) {
                      Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == LogoutScreenState.success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Log out',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LogoutBloc>(context).add(LogOut());
                          },
                          icon: Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<DarkThemeBloc, DarkThemeState>(
                    builder: (context, themeState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: themeState.isDarkMode
                                ? AppColors.grey
                                : AppColors.color1,
                          ),
                          Switch(
                            value: themeState.isDarkMode,
                            onChanged: (_) {
                              context
                                  .read<DarkThemeBloc>()
                                  .add(ToggleDarkTheme());
                            },
                          ),
                          Icon(
                            Icons.nightlight_round,
                            color: themeState.isDarkMode
                                ? AppColors.lightblue
                                : AppColors.grey,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
