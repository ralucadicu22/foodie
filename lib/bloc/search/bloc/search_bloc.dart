import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'search_event.dart';
part 'search_state.dart';

final YelpApiClient apiClient = YelpApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchEvent>((event, emit) {});
    on<SearchText>((event, emit) async {
      try {
        emit(state.copyWith(state: SearchStateEnum.loading));
        List<Restaurant> nearbyRestaurants =
            await apiClient.fetchnearbyRestaurants(
                term: 'restaurants', latitude: 34.0522, longitude: -118.2437);
        List<Restaurant> filtredrestaurants = nearbyRestaurants
            .where((restaurant) => restaurant.title
                .toLowerCase()
                .contains(event.searchList.toLowerCase().toString()))
            .toList();
        emit(state.copyWith(
            state: SearchStateEnum.loaded,
            nearbyRestaurants: filtredrestaurants));
      } catch (error) {
        debugPrint(error.toString());
        emit(state.copyWith(state: SearchStateEnum.error));
      }
    });
  }
}
