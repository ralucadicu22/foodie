import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:restaurant_app/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:restaurant_app/bloc/location/location_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/bloc/logout/bloc/logout_bloc.dart';
import 'package:restaurant_app/bloc/map/bloc/map_bloc.dart';
import 'package:restaurant_app/models/internal_database.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/screens/get_details_screen.dart';
import 'package:restaurant_app/screens/profile_screen.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(LocationDataAdapter());

  await Hive.openBox<Restaurant>('restaurantBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantBox = Hive.box<Restaurant>('restaurantBox');
    final String id;
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
          )
        ],
        child: MaterialApp(
          home: SplashScreen(),
        ));
  }
}
