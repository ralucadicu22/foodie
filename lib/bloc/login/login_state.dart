part of 'login_bloc.dart';

enum LoginScreenState { unauthenticated, loading, success, error }

class LoginState extends Equatable {
  final LoginScreenState state;

  final String? profileImage;
  final String? userName;
  final String? userMailAddress;
  const LoginState({
    this.state = LoginScreenState.unauthenticated,
    this.profileImage,
    this.userName,
    this.userMailAddress,
  });
  LoginState copyWith({
    LoginScreenState? state,
    String? profileImage,
    String? userName,
    String? userAddress,
    String? userMailAddress,
  }) =>
      LoginState(
        state: state ?? this.state,
        profileImage: profileImage,
        userName: userName,
        userMailAddress: userMailAddress,
      );

  @override
  List<Object> get props =>
      [state, profileImage ?? '', userName ?? '', userMailAddress ?? ''];
}
