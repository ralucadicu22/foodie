import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'logout_event.dart';
part 'logout_state.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutState()) {
    on<LogoutEvent>((event, emit) {});
    on<LogOut>((event, emit) async {
      try {
        emit(state.copyWith(state: LogoutScreenState.loading));

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove('email');
        preferences.remove('name');
        preferences.remove('image');
        preferences.setBool('isLoggedIn', false);
        await _googleSignIn.signOut();
        await FacebookAuth.instance.logOut();
        emit(state.copyWith(state: LogoutScreenState.success));
      } catch (error) {
        debugPrint(error.toString());
        emit(state.copyWith(state: LogoutScreenState.error));
      }
    });
  }
}
