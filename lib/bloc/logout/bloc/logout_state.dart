part of 'logout_bloc.dart';

enum LogoutScreenState {
  initial,
  loading,
  success,
  error,
}

class LogoutState extends Equatable {
  final LogoutScreenState state;

  const LogoutState({
    this.state = LogoutScreenState.initial,
  });
  LogoutState copyWith({LogoutScreenState? state}) => LogoutState(
        state: state ?? this.state,
      );

  @override
  List<Object> get props => [state];
}
