import 'package:flutter/material.dart';
import 'colors.dart';

class CustomeDot extends StatelessWidget {
  final index;
  final currentIndex;

  CustomeDot(this.index, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,
        alignment: Alignment.center,
        width: currentIndex == index ? 20 : 10,
        margin: EdgeInsets.only(right: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.white,
        ));
  }
}
