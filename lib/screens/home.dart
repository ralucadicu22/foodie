// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/nav_bar/bloc/navbar_bloc.dart';
import 'package:restaurant_app/bloc/search/bloc/search_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/models/navigation_bar.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/listing_screen.dart';
import 'package:searchfield/searchfield.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavbarBloc>(
          create: (context) => NavbarBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return SearchField(
                    itemHeight: 120,
                    onSearchTextChanged: (searchText) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchText(searchText));
                    },
                    hint: 'Search',
                    suggestions: state.nearbyRestaurants
                        .map((e) => SearchFieldListItem(e.title,
                            child: Expanded(child: ListContainer(e))))
                        .toList(),
                    searchInputDecoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: AppColors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.black))),
                  );
                },
              ),
            ),
            Expanded(child: BlocBuilder<NavbarBloc, NavbarState>(
              builder: (context, state) {
                return _pages[state.state.index];
              },
            )),
          ]),
          bottomNavigationBar: MyNavBar()),
    );
  }

  final List<Widget> _pages = [
    MyHomeScreen(),
    // LocationScreen(),
    // FavoriteScreen(),
    // ProfileScreen(),
  ];
}
