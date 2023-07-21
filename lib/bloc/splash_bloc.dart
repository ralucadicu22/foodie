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
    await Future.delayed(Duration(seconds: 10));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstTime = preferences.getBool('isFirstTime') ?? false;

    emit(state.copyWith(state: SplashScreenState.loaded));
  }
}
