import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'listing_event.dart';
part 'listing_state.dart';

final YelpApiClient apiClient = YelpApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc({required String type}) : super(ListingState(type: type)) {
    on<ListingEvent>((event, emit) {});
    on<LoadAllRestaurants>((event, emit) async {
      try {
        emit(state.copyWith(state: ListingScreenState.loading));
        switch (state.type) {
          case 'nearbyRestaurants':
            List<Restaurant> nearbyRestaurants =
                await apiClient.fetchnearbyRestaurants(
                    term: 'restaurants',
                    latitude: 34.0522,
                    longitude: -118.2437,
                    page: state.page);
            if (nearbyRestaurants.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...nearbyRestaurants],
                page: state.page + 1));

            break;
          case 'hotandnew':
            List<Restaurant> hotandnew =
                await apiClient.fetchHotAndNewRestaurants(
                    term: 'restaurants',
                    latitude: 34.0522,
                    longitude: -118.2437);
            if (hotandnew.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...hotandnew], page: state.page + 1));

            break;
          case 'deals':
            List<Restaurant> deals = await apiClient.fetchDeals(
                term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
            if (deals.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...deals], page: state.page + 1));
            break;

          case 'delivery':
            List<Restaurant> delivery = await apiClient.fetchDelivery(
                term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
            if (delivery.length < YelpApiClient.limit) {
              emit(state.copyWith(hasReachedMax: true));
            }
            emit(state.copyWith(
                result: [...state.result, ...delivery], page: state.page + 1));
            break;

          case 'takeaway':
            List<Restaurant> takeaway = await apiClient.fetchTakeAway(
                term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
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
      debugPrint('$state');
    });
  }
}
