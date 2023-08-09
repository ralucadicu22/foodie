import 'package:flutter/material.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/models/restaurant_widget.dart';
import 'package:restaurant_app/screens/listing_screen.dart';
import 'colors.dart';

class BuildScroll extends StatelessWidget {
  String title;
  final Function onpress;
  List<Restaurant> items;
  BuildScroll(this.title, this.items, this.onpress);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyListingScreen(initialCategory: title),
                      ),
                    );
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(fontSize: 20, color: AppColors.lightblue),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            child: PageView(
              padEnds: false,
              scrollDirection: Axis.horizontal,
              controller: PageController(initialPage: 0, viewportFraction: 0.7),
              children: List.generate(
                items.length,
                (index) => Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: RestaurantWidget(items[index]),
                    color: AppColors.color2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
