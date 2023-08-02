import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) {});
    on<LogInwithGoogle>((event, emit) {
      _loginwithgoogle();
    });
    on<LoginwithFacebook>((event, emit) {
      _loginwithfacebook();
    });
  }
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<void> _loginwithgoogle() async {
    emit(state.copyWith(state: LoginScreenState.loading));
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('isLoggedIn', true);
      final user = await _googleSignIn.signIn();
      if (user == null) {
        emit(state.copyWith(state: LoginScreenState.unauthenticated));
      } else {
        emit(state.copyWith(state: LoginScreenState.success));
      }
    } catch (error) {
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }

  Future<void> _loginwithfacebook() async {
    emit(state.copyWith(state: LoginScreenState.loading));
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('isLoggedIn', true);
      final userCredential = await signInWithFacebook();
      print('Facebook User: ${userCredential.user?.displayName}');

      emit(state.copyWith(state: LoginScreenState.success));
    } catch (error) {
      print('Facebook Login Error: $error');
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public profile'],
    );

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
