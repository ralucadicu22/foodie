import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/bloc/logout/bloc/logout_bloc.dart';
import 'package:restaurant_app/screens/profile_screen.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<LogoutBloc>(
            create: (context) => LogoutBloc(),
          ),
        ],
        child: MaterialApp(
          home: SplashScreen(),
        ));
  }
}
