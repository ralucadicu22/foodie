import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
      _loginWithFacebook();
    });
    on<GetLoginData>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? email = preferences.getString('email');
        String? name = preferences.getString('name');
        String? image = preferences.getString('image');
        preferences.setBool('isLoggedIn',
            true && email != null && name != null && image != null);

        if (email != null && name != null && image != null) {
          emit(state.copyWith(
            userName: name,
            userMailAddress: email,
            profileImage: image,
            state: LoginScreenState.success,
          ));
        } else {
          emit(state.copyWith(state: LoginScreenState.unauthenticated));
        }
      } catch (error) {
        debugPrint(error.toString());
        emit(state.copyWith(state: LoginScreenState.error));
      }
    });
    on<CreateAccountWithEmailAndPassword>((event, emit) {
      _createAccountWithEmailAndPasword(event.email, event.password);
    });

    on<SignInWithEmailAndPassword>((event, emit) {
      _signInWithEmailAndPasword(event.email, event.password);
    });
  }
  Future<void> _createAccountWithEmailAndPasword(
      String email, String password) async {
    emit(state.copyWith(state: LoginScreenState.loading));

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(state: LoginScreenState.success));
    } catch (error) {
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }

  Future<void> _signInWithEmailAndPasword(String email, String password) async {
    emit(state.copyWith(state: LoginScreenState.loading));

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(state: LoginScreenState.success));
    } catch (error) {
      emit(state.copyWith(state: LoginScreenState.error));
    }
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
        debugPrint(state.toString());
        print(user.email);
        print(user.displayName);
        emit(state.copyWith(
          state: LoginScreenState.success,
          profileImage: user.photoUrl,
          userName: user.displayName,
          userMailAddress: user.email,
        ));
        add(GetLoginData());
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }

  Future<void> _loginWithFacebook() async {
    emit(state.copyWith(state: LoginScreenState.loading));

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        final String? displayName = userCredential.user?.displayName;
        final String? email = userCredential.user?.email;
        final String? photoURL = userCredential.user?.photoURL;

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('isLoggedIn', true);

        if (email != null) {
          preferences.setString('email', email);
        }
        if (displayName != null) {
          preferences.setString('name', displayName);
        }
        if (photoURL != null) {
          preferences.setString('image', photoURL);
        }

        emit(state.copyWith(
          state: LoginScreenState.success,
          profileImage: photoURL,
          userName: displayName,
          userMailAddress: email,
        ));
        add(GetLoginData());
      } else if (loginResult.status == LoginStatus.cancelled) {
        emit(state.copyWith(state: LoginScreenState.error));
      } else {
        emit(state.copyWith(state: LoginScreenState.error));
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(state: LoginScreenState.error));
    }
  }
}
