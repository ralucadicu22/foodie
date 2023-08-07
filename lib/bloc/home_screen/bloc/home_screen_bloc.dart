import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

final YelpApiClient apiClient = YelpApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState()) {
    on<HomeScreenEvent>((event, emit) {});

    on<FetchData>((event, emit) async {
      try {
        emit(state.copyWith(state: HomeState.loading));
        List<Restaurant> nearbyRestaurants =
            await apiClient.fetchnearbyRestaurants(
                term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        List<Restaurant> hotandnew = await apiClient.fetchHotAndNewRestaurants(
            term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        List<Restaurant> deals = await apiClient.fetchDeals(
            term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        List<Restaurant> delivery = await apiClient.fetchDelivery(
            term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        List<Restaurant> takeaway = await apiClient.fetchTakeAway(
            term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        emit(state.copyWith(
            nearbyRestaurants: nearbyRestaurants,
            hotandnew: hotandnew,
            deals: deals,
            delivery: delivery,
            takeaway: takeaway,
            state: HomeState.loaded));
      } catch (error) {
        debugPrint(error.toString());
        emit(state.copyWith(state: HomeState.error));
      }
    });
  }
}
