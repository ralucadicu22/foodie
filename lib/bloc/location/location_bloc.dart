import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<LocationEvent>((event, emit) {});
    on<FetchLocation>((event, emit) {
      fetchlocation();
    });
    on<RequestLocation>((event, emit) {
      requestlocation();
    });
  }
  Future<void> fetchlocation() async {
    final Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      emit(LocationState(state: LocationStateEnum.nolocation));
      return;
    } else {
      _locationData = await location.getLocation();
      emit(LocationState(state: LocationStateEnum.granted));
    }
  }

  Future<void> requestlocation() async {
    final Location location = Location();
    PermissionStatus _permissionRequested = await location.requestPermission();
    if (_permissionRequested == PermissionStatus.granted) {
      emit(LocationState(state: LocationStateEnum.granted));
    } else {
      emit(LocationState(state: LocationStateEnum.denied));
    }
  }
}
