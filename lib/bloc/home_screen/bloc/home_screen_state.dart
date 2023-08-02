part of 'home_screen_bloc.dart';

enum HomeState { init, loading, loaded, error }

class HomeScreenState extends Equatable {
  final List<Restaurant> nearbyRestaurants;
  final List<Restaurant> hotandnew;
  final List<Restaurant> deals;
  final List<Restaurant> delivery;
  final List<Restaurant> takeaway;
  final HomeState state;
  final HomeState error;

  const HomeScreenState(
      {this.nearbyRestaurants = const [],
      this.hotandnew = const [],
      this.deals = const [],
      this.delivery = const [],
      this.takeaway = const [],
      this.state = HomeState.init,
      this.error = HomeState.error});

  HomeScreenState copyWith({
    List<Restaurant>? nearbyRestaurants,
    List<Restaurant>? hotandnew,
    List<Restaurant>? deals,
    List<Restaurant>? delivery,
    List<Restaurant>? takeaway,
    HomeState? state,
    HomeState? error,
  }) {
    return HomeScreenState(
        nearbyRestaurants: nearbyRestaurants ?? this.nearbyRestaurants,
        hotandnew: hotandnew ?? this.hotandnew,
        deals: deals ?? this.deals,
        delivery: delivery ?? this.delivery,
        takeaway: takeaway ?? this.takeaway,
        state: state ?? this.state,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props =>
      [nearbyRestaurants, hotandnew, deals, delivery, takeaway, state, error];
}
