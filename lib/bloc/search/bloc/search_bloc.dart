import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'search_event.dart';
part 'search_state.dart';

final YelpApiClient apiClient = YelpApiClient(AppConfig().api_key);

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchEvent>((event, emit) {});
    on<SearchText>((event, emit) async {
      emit(state.copyWith(state: SearchStateEnum.loading));
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            emit(state.copyWith(state: SearchStateEnum.error));
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            emit(state.copyWith(state: SearchStateEnum.error));
            return;
          }
        }

        LocationData locationData = await location.getLocation();
        List<Restaurant> nearbyRestaurants =
            await apiClient.fetchnearbyRestaurants(
                term: 'restaurants', locationData: locationData);
        List<Restaurant> filtredrestaurants = nearbyRestaurants
            .where((restaurant) => restaurant.title
                .toLowerCase()
                .contains(event.searchList.toLowerCase().toString()))
            .toList();
        emit(state.copyWith(
            state: SearchStateEnum.loaded,
            nearbyRestaurants: filtredrestaurants));
      } catch (error) {
        emit(state.copyWith(state: SearchStateEnum.error));
      }
    });
  }
}
