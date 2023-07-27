import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<LocationEvent>((event, emit) {});
    on<FetchLocation>((event, emit) {
      fetchlocation();
    });
  }
  Future<void> fetchlocation() async {
    final Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(LocationState(state: LocationStateEnum.denied));
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(LocationState(state: LocationStateEnum.denied));
        return;
      }
    }

    _locationData = await location.getLocation();
    emit(LocationState(state: LocationStateEnum.granted));
  }
}
