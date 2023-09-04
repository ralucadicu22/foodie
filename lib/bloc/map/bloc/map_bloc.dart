import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/api_map.dart';
import 'package:restaurant_app/map.dart';
import 'package:restaurant_app/models/app_config.dart';

import 'package:restaurant_app/models/restaurant_map.dart';

part 'map_event.dart';
part 'map_state.dart';

final ApiMap apiMap = ApiMap(apiKey: AppConfig().api_key);

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<MapEvent>((event, emit) {});
    on<FetchRestaurantsEvent>((event, emit) async {
      emit(state.copyWith(state: MapScreenState.loading));
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            emit(state.copyWith(state: MapScreenState.error));
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            emit(state.copyWith(state: MapScreenState.error));
            return;
          }
        }

        LocationData locationData = await location.getLocation();

        final restaurants = await apiMap.fetchLocationRestaurants(
            location: locationData, radius: 5000);

        emit(state.copyWith(
            state: MapScreenState.loaded, restaurantMap: restaurants));
      } catch (error) {
        emit(state.copyWith(state: MapScreenState.error));
      }
    });
  }
}
