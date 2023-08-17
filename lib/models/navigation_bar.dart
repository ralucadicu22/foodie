// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/nav_bar/bloc/navbar_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/screens/home_screen.dart';

class MyNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar();
  }
}

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.state.index,
          onTap: (index) {
            final page = _navigate(index);

            context.read<NavbarBloc>().add(ChangePage(page));
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined, color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.favorite_border_outlined, color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined, color: AppColors.black),
              label: '',
            ),
          ],
        );
      },
    );
  }

  NavBarStateEnum _navigate(int index) {
    switch (index) {
      case 0:
        return NavBarStateEnum.home;
      case 1:
        return NavBarStateEnum.location;
      case 2:
        return NavBarStateEnum.favorites;
      case 3:
        return NavBarStateEnum.profile;
      default:
        return NavBarStateEnum.home;
    }
  }
}
