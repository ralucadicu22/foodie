import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/app_config.dart';
import 'package:restaurant_app/models/get_details_models/restaurant_detailed.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';

class RestaurantDetailedApiClient {
  final String apiKey;

  RestaurantDetailedApiClient(this.apiKey);

  Future<RestaurantDetailed> fetchRestaurantDetails({
    required String id,
  }) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'id': id,
    };
    final Uri uri =
        Uri.parse('${AppConfig().url_base}${AppConfig().pathDetails}$id')
            .replace(queryParameters: queryParameters);
    debugPrint('${AppConfig().url_base}${AppConfig().pathDetails}$id');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return RestaurantDetailed.fromJson(data);
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}

class ReviewApiClient {
  final String apiKey;

  ReviewApiClient(this.apiKey);

  Future<List<Review>> fetchRestaurantReviews(String id) async {
    final Map<String, String> headers = {
      'Authorization': AppConfig().security_key,
    };
    final Map<String, dynamic> queryParameters = {
      'id': id,
    };
    final Uri uri = Uri.parse(
            '${AppConfig().url_base}${AppConfig().pathReviews}$id/reviews?limit=20&sort_by=yelp_sort')
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data['reviews'] as List).map((e) => Review.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load restaurant reviews');
    }
  }
}
