// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/buildScroll.dart';
import 'package:restaurant_app/yelp_api.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _search = TextEditingController();
  final PageController carouselController = PageController(initialPage: 0);
  final PageController listController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final List<String> items = List.generate(3, (index) => "Item ${index + 1}");
  final YelpApiClient apiClient = YelpApiClient(
      'gW3UrUJaOU6Y6lzBSnyltFkMmgq0euWNCy-Bq-Tp4J6WVCfKgZCn5AdovrJk-n_5rglCBGiTAA3mubt4960cI2Xtd2teyh1P7Vj4FKLOaRiLuJjNyvl_ttcFDH_HZHYx');
  List<dynamic> nearbyRestaurants = [];
  @override
  void initState() {
    super.initState();
    fetchnearbyRestaurants();
  }

  Future<void> fetchnearbyRestaurants() async {
    try {
      final data = await apiClient.fetchnearbyRestaurants(
        latitude: 41.1579,
        longitude: -8.6291,
        term: 'restaurants',
      );

      setState(() {
        nearbyRestaurants = data;
      });
    } catch (e) {
      print('Error fetching nearby restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _search,
          decoration: InputDecoration(
            labelText: 'Search',
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              child: Container(
                height: 150,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: carouselController,
                  itemCount: nearbyRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = nearbyRestaurants[index];
                    final imageUrl = restaurant['image_url'] ?? '';

                    return Stack(
                      children: [
                        Image.network(
                          imageUrl,
                          height: 150,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            color: AppColors.white.withOpacity(0.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant['name'] ?? 'Unknown',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  restaurant['location']['address1'] ??
                                      'Address not available',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          BuildScroll(
            'Most Popular',
            listController,
            items,
          ),
          BuildScroll(
            'Meal Deals',
            listController,
            items,
          ),
          BuildScroll(
            'Restaurants with delivery',
            listController,
            items,
          ),
          BuildScroll(
            'Take-out Restaurants',
            listController,
            items,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: AppColors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined, color: AppColors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined, color: AppColors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: AppColors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}
