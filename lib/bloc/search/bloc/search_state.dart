part of 'search_bloc.dart';

enum SearchStateEnum { init, loading, loaded, error }

class SearchState extends Equatable {
  final SearchStateEnum state;
  final List<Restaurant> nearbyRestaurants;

  const SearchState({
    this.state = SearchStateEnum.init,
    this.nearbyRestaurants = const [],
  });

  SearchState copyWith({
    SearchStateEnum? state,
    List<Restaurant>? nearbyRestaurants,
  }) {
    return SearchState(
      state: state ?? this.state,
      nearbyRestaurants: nearbyRestaurants ?? this.nearbyRestaurants,
    );
  }

  @override
  List<Object> get props => [nearbyRestaurants, state];
}
