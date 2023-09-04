import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

import 'package:restaurant_app/models/app_config.dart';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant_map.dart';

class ApiMap {
  final String apiKey;
  ApiMap({required this.apiKey});
  Future<List<RestaurantMapModel>> fetchLocationRestaurants({
    required LocationData location,
    required int radius,
  }) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'location': '${location.latitude},${location.longitude}',
      'radius': radius.toString(),
    };

    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data['businesses'] as List).map((e) {
        RestaurantMapModel model = RestaurantMapModel.fromJson(e);

        return model;
      }).toList();
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}
