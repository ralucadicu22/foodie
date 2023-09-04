import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'listing_event.dart';
part 'listing_state.dart';

final YelpApiClient apiClient = YelpApiClient(AppConfig().api_key);

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc({required String type}) : super(ListingState(type: type)) {
    on<ListingEvent>((event, emit) {});
    on<LoadAllRestaurants>((event, emit) async {
      emit(state.copyWith(state: ListingScreenState.loading));

      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            emit(state.copyWith(state: ListingScreenState.error));
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            emit(state.copyWith(state: ListingScreenState.error));
            return;
          }
        }

        LocationData locationData = await location.getLocation();
        switch (state.type) {
          case 'Most Popular':
            List<Restaurant> hotandnew =
                await apiClient.fetchHotAndNewRestaurants(
                    term: 'restaurants', locationData: locationData);
            if (hotandnew.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...hotandnew], page: state.page + 1));

            break;
          case 'Meal Deals':
            List<Restaurant> deals = await apiClient.fetchDeals(
                term: 'restaurants', locationData: locationData);
            if (deals.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...deals], page: state.page + 1));
            break;

          case 'Restaurants with delivery':
            List<Restaurant> delivery = await apiClient.fetchDelivery(
                term: 'restaurants', locationData: locationData);
            if (delivery.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...delivery], page: state.page + 1));
            break;

          case 'TakeAway Restaurants':
            List<Restaurant> takeaway = await apiClient.fetchTakeAway(
                term: 'restaurants', locationData: locationData);
            if (takeaway.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...takeaway], page: state.page + 1));
            break;
          default:
            break;
        }

        emit(state.copyWith(state: ListingScreenState.loaded));
      } catch (error) {
        emit(state.copyWith(state: ListingScreenState.error));
      }
    });
  }
}
