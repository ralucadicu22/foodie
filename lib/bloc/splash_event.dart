part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class StartLoadingEvent extends SplashEvent {
  const StartLoadingEvent();
  @override
  List<Object> get props => [];
}
