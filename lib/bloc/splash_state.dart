part of 'splash_bloc.dart';

enum SplashScreenState { init, loading, loaded }

class SplashState extends Equatable {
  final SplashScreenState state;

  const SplashState({
    this.state = SplashScreenState.init,
  });
  SplashState copyWith({
    SplashScreenState? state,
  }) =>
      SplashState(state: state ?? this.state);

  @override
  List<Object> get props => [state];
}
