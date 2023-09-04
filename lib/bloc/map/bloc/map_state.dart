part of 'map_bloc.dart';

enum MapScreenState {
  init,
  loading,
  loaded,
  error,
}

class MapState extends Equatable {
  final MapScreenState state;
  final List<RestaurantMapModel> restaurantMap;

  const MapState({
    this.state = MapScreenState.init,
    this.restaurantMap = const [],
  });
  MapState copyWith(
          {MapScreenState? state, List<RestaurantMapModel>? restaurantMap}) =>
      MapState(
        state: state ?? this.state,
        restaurantMap: restaurantMap ?? this.restaurantMap,
      );

  @override
  List<Object?> get props => [state, restaurantMap];
}
