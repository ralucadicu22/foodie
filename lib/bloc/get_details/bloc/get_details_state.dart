part of 'get_details_bloc.dart';

enum GetDetailsScreenState { init, loading, loaded, error }

class GetDetailsState extends Equatable {
  final GetDetailsScreenState state;
  final RestaurantDetailed? restaurant;
  final List<Review>? reviews;

  const GetDetailsState({
    this.state = GetDetailsScreenState.init,
    this.restaurant,
    this.reviews,
  });

  GetDetailsState copyWith({
    GetDetailsScreenState? state,
    RestaurantDetailed? restaurant,
    List<Review>? reviews,
  }) {
    return GetDetailsState(
      state: state ?? this.state,
      restaurant: restaurant ?? this.restaurant,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [state, restaurant, reviews];
}
