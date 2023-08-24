import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/list_container.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Center(
          child: Text(
            'Favourite',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.state == FavoritesScreenState.loaded) {
            if (state.favorites.isEmpty) {
              return Text('No restaurants');
            } else {
              return ListView(
                children: state.favorites.map((restaurant) {
                  return ListContainer(
                    restaurant,
                    showImage: true,
                  );
                }).toList(),
              );
            }
          } else {
            return Text('error');
          }
        },
      ),
    );
  }
}
