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
    on<GetLoginData>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.getString('email');
      preferences.getString(
        'name',
      );
      preferences.getString('image');
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
        preferences.setString('email', user.email);
        preferences.setString('name', user.displayName ?? '');
        preferences.setString('image', user.photoUrl ?? '');
        emit(state.copyWith(
            state: LoginScreenState.success,
            profileImage: user.photoUrl,
            userName: user.displayName,
            userMailAddress: user.email));
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
      preferences.setString('email', userCredential.user?.email ?? '');
      preferences.setString('name', userCredential.user?.displayName ?? '');
      preferences.setString('image', userCredential.user?.photoURL ?? '');
      emit(state.copyWith(
          state: LoginScreenState.success,
          profileImage: userCredential.user?.photoURL,
          userName: userCredential.user?.displayName,
          userMailAddress: userCredential.user?.email));
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
