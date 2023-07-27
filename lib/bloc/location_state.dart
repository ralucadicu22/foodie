part of 'location_bloc.dart';

enum LocationStateEnum { nolocation, loading, granted, denied }

class LocationState extends Equatable {
  final LocationStateEnum state;

  const LocationState({
    this.state = LocationStateEnum.nolocation,
  });
  LocationState copyWith({LocationStateEnum? state}) => LocationState(
        state: state ?? this.state,
      );

  @override
  List<Object> get props => [state];
}
