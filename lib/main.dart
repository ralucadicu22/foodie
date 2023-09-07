import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app/bloc/dark_theme/bloc/dark_theme_bloc.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/bloc/logout/bloc/logout_bloc.dart';
import 'package:restaurant_app/bloc/map/bloc/map_bloc.dart';
import 'package:restaurant_app/models/dynamic_link.dart';

import 'package:restaurant_app/models/internal_database.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Firebase.initializeApp(
      name: '[DEFAULT]',
      options: FirebaseOptions(
          apiKey: "AIzaSyDySpqAQziAP9w1eF0f5CAMZsj7mv8zjPs",
          appId: "1:667685998636:android:4822be305fb4baba4b0189",
          messagingSenderId: "667685998636",
          projectId: "restaurantapp-393807"));
  DynamicLinkProvider().initDynamicLink();

  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(LocationDataAdapter());

  await Hive.openBox<Restaurant>('restaurantBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantBox = Hive.box<Restaurant>('restaurantBox');

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(restaurantBox),
        ),
        BlocProvider(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
          create: (context) => DarkThemeBloc(),
        ),
      ],
      child: BlocBuilder<DarkThemeBloc, DarkThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
