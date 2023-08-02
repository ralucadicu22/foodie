// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/nav_bar/bloc/navbar_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/navigation_bar.dart';
import 'package:restaurant_app/screens/home_screen.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarBloc(),
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        body: BlocBuilder<NavbarBloc, NavbarState>(
          builder: (context, state) {
            return _pages[state.state.index];
          },
        ),
        bottomNavigationBar: MyNavBar());
  }

  final List<Widget> _pages = [
    MyHomeScreen(),
    // LocationScreen(),
    // FavoriteScreen(),
    // ProfileScreen(),
  ];
}
