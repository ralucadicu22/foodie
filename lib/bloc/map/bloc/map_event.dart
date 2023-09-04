part of 'map_bloc.dart';

class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurantsEvent extends MapEvent {
  final Location location;
  final int radius;

  FetchRestaurantsEvent({
    required this.location,
    required this.radius,
  });

  @override
  List<Object> get props => [location, radius];
}
