part of 'splash_bloc.dart';

enum SplashScreenState { init, loading, loaded }

enum PageRedirect { firstTime, login, home }

class SplashState extends Equatable {
  final SplashScreenState state;
  final PageRedirect redirect;

  const SplashState({
    this.state = SplashScreenState.init,
    this.redirect = PageRedirect.firstTime,
  });
  SplashState copyWith({SplashScreenState? state, PageRedirect? redirect}) =>
      SplashState(
        state: state ?? this.state,
        redirect: redirect ?? this.redirect,
      );

  @override
  List<Object> get props => [state, redirect];
}
