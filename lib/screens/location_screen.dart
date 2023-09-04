import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/bloc/map/bloc/map_bloc.dart';

import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/container_map.dart';
import 'package:restaurant_app/models/custom_marker.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/screens/get_details_screen.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MapBloc>(context)
        .add(FetchRestaurantsEvent(location: Location(), radius: 5000));
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state.state == MapScreenState.loaded) {
          return Scaffold(
            body: FlutterMap(
              mapController: MapController(),
              options: MapOptions(
                center: LatLng(34.0549, -118.2426),
                zoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: state.restaurantMap.map((restaurant) {
                    return Marker(
                      width: 60,
                      height: 60,
                      point: LatLng(
                        restaurant.coordinatesMap.latitude,
                        restaurant.coordinatesMap.longitude,
                      ),
                      builder: (context) => GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ContainerMap(
                                id: restaurant.idMap,
                                restaurantMapModel: restaurant,
                              );
                            },
                          );
                        },
                        child: CustomMarker(
                          imageUrl: restaurant.imageUrlMap,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else if (state.state == MapScreenState.error) {
          return Text('Error loading restaurants');
        } else {
          return Container();
        }
      },
    );
  }
}
