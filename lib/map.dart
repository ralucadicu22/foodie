import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restaurant_app/models/colors.dart';

class RestaurantMap extends StatelessWidget {
  final double lat;
  final double long;

  RestaurantMap({required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    final LatLng customLatLng = LatLng(lat, long);
    final MapController mapController = MapController();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: customLatLng,
          zoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 48,
                height: 48,
                point: customLatLng,
                builder: (context) => GestureDetector(
                  onTap: () {
                    mapController.move(customLatLng, 18);
                  },
                  child: Container(
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static fromJson(e) {}
}
