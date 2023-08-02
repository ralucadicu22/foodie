part of 'login_bloc.dart';

enum LoginScreenState { unauthenticated, loading, success, error }

class LoginState extends Equatable {
  final LoginScreenState state;
  final LoginScreenState error;
  const LoginState({
    this.state = LoginScreenState.unauthenticated,
    this.error = LoginScreenState.error,
  });
  LoginState copyWith({LoginScreenState? state}) => LoginState(
        state: state ?? this.state,
        error: error,
      );

  @override
  List<Object> get props => [state, error];
}
