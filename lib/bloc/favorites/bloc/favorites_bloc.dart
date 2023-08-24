import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app/models/location_data_model.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final Box<Restaurant> restaurantBox;

  FavoritesBloc(this.restaurantBox) : super(FavoritesState()) {
    on<FavoritesEvent>((event, emit) {});
    on<AddToFavorites>((event, emit) {
      _addToFavorites(event.restaurant);
    });
    on<RemoveFromFavorites>((event, emit) {
      _removeFromFavorites(event.restaurant);
    });
  }
  Future<void> _addToFavorites(Restaurant restaurant) async {
    debugPrint(state.toString());
    emit(state.copyWith(state: FavoritesScreenState.loading));
    try {
      final isNotInFavorites = !state.favorites
          .any((otherRestaurant) => otherRestaurant.id == restaurant.id);

      if (isNotInFavorites) {
        final newFavorites = [...state.favorites, restaurant];
        restaurantBox.put(restaurant.id, restaurant);

        emit(state.copyWith(
            state: FavoritesScreenState.loaded, favorites: newFavorites));
      } else {
        emit(state.copyWith(state: FavoritesScreenState.loaded));
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(state: FavoritesScreenState.error));
    }
  }

  Future<void> _removeFromFavorites(Restaurant restaurant) async {
    final newFavorites = List<Restaurant>.from(state.favorites);
    newFavorites
        .removeWhere((otherRestaurant) => otherRestaurant.id == restaurant.id);
    restaurantBox.delete(restaurant.id);

    emit(state.copyWith(
        favorites: newFavorites, state: FavoritesScreenState.loaded));
  }
}
