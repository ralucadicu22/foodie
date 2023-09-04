import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class YelpApiClient {
  final String apiKey;
  static int limit = 10;
  YelpApiClient(this.apiKey);

  Future<List<Restaurant>> fetchnearbyRestaurants(
      {required LocationData locationData,
      required String term,
      int? page}) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'location': '${locationData.latitude},${locationData.longitude}',
      'term': term,
    };
    if (page != null) {
      queryParameters["limit"] = limit;
      queryParameters["offset"] = page * limit;
    }
    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['businesses'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Restaurant>> fetchHotAndNewRestaurants(
      {required String term,
      required LocationData locationData,
      int? page}) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'term': term,
      'location': '${locationData.latitude},${locationData.longitude}',
      'attributes': 'hot_and_new',
    };
    if (page != null) {
      queryParameters["limit"] = limit;
      queryParameters["offset"] = page * limit;
    }

    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['businesses'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Restaurant>> fetchDeals(
      {required String term,
      required LocationData locationData,
      int? page}) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'term': term,
      'location': '${locationData.latitude},${locationData.longitude}',
      'attributes': 'deals',
    };
    if (page != null) {
      queryParameters["limit"] = limit;
      queryParameters["offset"] = page * limit;
    }

    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['businesses'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Restaurant>> fetchDelivery(
      {required String term,
      required LocationData locationData,
      int? page}) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'term': term,
      'location': '${locationData.latitude},${locationData.longitude}',
      'attributes': 'restaurants_delivery',
    };
    if (page != null) {
      queryParameters["limit"] = limit;
      queryParameters["offset"] = page * limit;
    }
    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['businesses'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Restaurant>> fetchTakeAway(
      {required String term,
      required LocationData locationData,
      int? page}) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'term': term,
      'location': '${locationData.latitude},${locationData.longitude}',
      'attributes': 'restaurants_takeaway',
    };
    if (page != null) {
      queryParameters["limit"] = limit;
      queryParameters["offset"] = page * limit;
    }

    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathSearch}')
            .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['businesses'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
