part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogInwithGoogle extends LoginEvent {}

class LoginwithFacebook extends LoginEvent {}

class GetLoginData extends LoginEvent {}

class CreateAccountWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  CreateAccountWithEmailAndPassword(
      {required this.email, required this.password});
}

class SignInWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});
}
