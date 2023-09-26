import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api_detailed.dart';
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

part 'get_details_event.dart';
part 'get_details_state.dart';

final RestaurantDetailedApiClient apiKey =
    RestaurantDetailedApiClient(AppConfig().api_key);
final ReviewApiClient apiClient = ReviewApiClient(AppConfig().api_key);

class GetDetailsBloc extends Bloc<GetDetailsEvent, GetDetailsState> {
  GetDetailsBloc({required String id}) : super(GetDetailsState()) {
    on<GetDetailsEvent>((event, emit) {});
    on<FetchDetails>((event, emit) async {
      emit(state.copyWith(state: GetDetailsScreenState.loading));
      try {
        final RestaurantDetailed restaurant =
            await apiKey.fetchRestaurantDetails(
          id: id,
        );
        final List<Review> reviews = await apiClient.fetchRestaurantReviews(id);
        emit(state.copyWith(
          state: GetDetailsScreenState.loaded,
          restaurant: restaurant,
          reviews: reviews,
        ));
      } catch (error) {
        emit(state.copyWith(state: GetDetailsScreenState.error));
      }
    });
    on<ReadMoreReviews>((event, emit) async {
      final updatedReviews = state.reviews!.map((review) {
        if (review == event.review) {
          return review.copyWith(expanded: !review.expanded);
        } else {
          return review;
        }
      }).toList();

      emit(state.copyWith(reviews: updatedReviews));
    });
  }
}