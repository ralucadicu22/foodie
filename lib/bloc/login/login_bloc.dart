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
      String? email = preferences.getString(
        'email',
      );
      String? name = preferences.getString('name');
      String? image = preferences.getString('image');
      if (email != null && name != null && image != null) {
        emit(state.copyWith(
          userName: name,
          userMailAddress: email,
          profileImage: image,
          state: LoginScreenState.success,
        ));
      }
      print('Retrieved email: $email');
      print('Retrieved name: $name');
      print('Retrieved image: $image');
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
      final user = await _googleSignIn.signIn();
      if (user == null) {
        emit(state.copyWith(state: LoginScreenState.unauthenticated));
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('isLoggedIn', true);

        if (user.email != null) {
          preferences.setString('email', user.email!);
        }
        if (user.displayName != null) {
          preferences.setString('name', user.displayName!);
        }
        if (user.photoUrl != null) {
          preferences.setString('image', user.photoUrl!);
        }

        emit(state.copyWith(
          state: LoginScreenState.success,
          profileImage: user.photoUrl,
          userName: user.displayName,
          userMailAddress: user.email,
        ));
        add(GetLoginData());
      }
    } catch (error) {
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }

  Future<void> _loginwithfacebook() async {
    emit(state.copyWith(state: LoginScreenState.loading));
    try {
      final userCredential = await signInWithFacebook();
      print('Facebook User: ${userCredential.user?.displayName}');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('isLoggedIn', true);

      if (userCredential.user?.email != null) {
        preferences.setString('email', userCredential.user!.email!);
      }
      if (userCredential.user?.displayName != null) {
        preferences.setString('name', userCredential.user!.displayName!);
      }
      if (userCredential.user?.photoURL != null) {
        preferences.setString('image', userCredential.user!.photoURL!);
      }

      emit(state.copyWith(
        state: LoginScreenState.success,
        profileImage: userCredential.user?.photoURL,
        userName: userCredential.user?.displayName,
        userMailAddress: userCredential.user?.email,
      ));
      add(GetLoginData());
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
