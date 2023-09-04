import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

final YelpApiClient apiClient = YelpApiClient(AppConfig().api_key);

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState()) {
    on<HomeScreenEvent>((event, emit) {});

    on<FetchData>((event, emit) async {
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      emit(state.copyWith(state: HomeState.loading));

      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            emit(state.copyWith(state: HomeState.error));
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            emit(state.copyWith(state: HomeState.error));
            return;
          }
        }

        LocationData locationData = await location.getLocation();
        List<Restaurant> nearbyRestaurants =
            await apiClient.fetchnearbyRestaurants(
                term: 'restaurants', locationData: locationData);
        List<Restaurant> hotandnew = await apiClient.fetchHotAndNewRestaurants(
            term: 'restaurants', locationData: locationData);
        List<Restaurant> deals = await apiClient.fetchDeals(
            term: 'restaurants', locationData: locationData);
        List<Restaurant> delivery = await apiClient.fetchDelivery(
            term: 'restaurants', locationData: locationData);
        List<Restaurant> takeaway = await apiClient.fetchTakeAway(
            term: 'restaurants', locationData: locationData);
        emit(state.copyWith(
            nearbyRestaurants: nearbyRestaurants,
            hotandnew: hotandnew,
            deals: deals,
            delivery: delivery,
            takeaway: takeaway,
            state: HomeState.loaded));
      } catch (error) {
        emit(state.copyWith(state: HomeState.error));
      }
    });
  }
}
