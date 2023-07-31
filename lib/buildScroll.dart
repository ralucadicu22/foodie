import 'package:flutter/material.dart';
import 'colors.dart';

class BuildScroll extends StatelessWidget {
  String title;
  PageController controller;
  List<String> items;
  BuildScroll(this.title, this.controller, this.items);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
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
                onPressed: () {},
                child: Text(
                  'See all',
                  style: TextStyle(fontSize: 20, color: AppColors.lightblue),
                ),
              ),
            ],
          ),
          Container(
            height: 120,
            child: PageView(
              pageSnapping: false,
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: List.generate(
                items.length,
                (index) => Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(items[index]),
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
