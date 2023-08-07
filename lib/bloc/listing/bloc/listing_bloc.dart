import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/yelp_api.dart';

part 'listing_event.dart';
part 'listing_state.dart';

final YelpApiClient apiClient = YelpApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc() : super(ListingState()) {
    on<ListingEvent>((event, emit) {});
    on<LoadAllRestaurants>((event, emit) async {
      try {
        emit(state.copyWith(state: ListingStateEnum.loading));
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
        final categories = [
          CategoriesRestaurants('Most Popular', nearbyRestaurants),
          CategoriesRestaurants('Meal Deals', deals),
          CategoriesRestaurants('Restaurants with delivery', delivery),
          CategoriesRestaurants('TakeAway Restaurants', takeaway),
        ];
        emit(state.copyWith(
            categories: categories, state: ListingStateEnum.loaded));
      } catch (error) {
        emit(state.copyWith(state: ListingStateEnum.error));
      }
    });
  }
}
