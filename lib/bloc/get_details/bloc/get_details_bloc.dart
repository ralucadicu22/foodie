import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api_detailed.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

part 'get_details_event.dart';
part 'get_details_state.dart';

final RestaurantDetailedApiClient apiKey = RestaurantDetailedApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');
final ReviewApiClient apiClient = ReviewApiClient(
    'jbH2y2WehwaV_WrooLAhyj-PrIjAUg7IhpH2ISpfjo0DGh82HV_8FcOxsgGMfHb9OMAphxC6g172YtgqF5RxIF_tjjsmbnlQWceuAJkGR2SRWmQGNO9fl9HnnCrKZHYx');

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
        debugPrint(error.toString());
        emit(state.copyWith(state: GetDetailsScreenState.error));
      }
    });
  }
}
