import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/main_screen.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SplashScreen(),
      home: MyMain(),
    );
  }
}
