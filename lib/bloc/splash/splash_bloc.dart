// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<SplashEvent>((event, emit) {});
    on<StartLoadingEvent>((event, emit) {
      init();
    });
  }

  init() async {
    emit(state.copyWith(state: SplashScreenState.loading));
    await Future.delayed(Duration(seconds: 5));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstTime = preferences.getBool('isFirstTime') ?? true;
    bool isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
    if (isFirstTime) {
      await preferences.setBool('isFirstTime', false);
      emit(state.copyWith(
          state: SplashScreenState.loaded, redirect: PageRedirect.firstTime));
    } else if (isLoggedIn) {
      emit(state.copyWith(
          state: SplashScreenState.loaded, redirect: PageRedirect.home));
    } else {
      emit(state.copyWith(
          state: SplashScreenState.loaded, redirect: PageRedirect.login));
    }
  }
}
