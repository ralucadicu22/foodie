import 'dart:convert';

import 'package:http/http.dart' as http;

class YelpApiClient {
  final String apiKey;

  YelpApiClient(this.apiKey);

  Future<List<dynamic>> fetchnearbyRestaurants(
      {required double latitude,
      required double longitude,
      required String term}) async {
    String apiUrl = 'https://api.yelp.com/v3/businesses/search';
    final Map<String, String> headers = {
      'Authorization':
          'Bearer gW3UrUJaOU6Y6lzBSnyltFkMmgq0euWNCy-Bq-Tp4J6WVCfKgZCn5AdovrJk-n_5rglCBGiTAA3mubt4960cI2Xtd2teyh1P7Vj4FKLOaRiLuJjNyvl_ttcFDH_HZHYx'
    };
    final Map<String, String> queryParameters = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'term': term,
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['businesses'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
