part of 'navbar_bloc.dart';

enum NavBarStateEnum {
  home,
  location,
  favorites,
  profile,
}

class NavbarState extends Equatable {
  final NavBarStateEnum state;
  const NavbarState({
    this.state = NavBarStateEnum.home,
  });
  NavbarState copyWith({NavBarStateEnum? state}) =>
      NavbarState(state: state ?? this.state);

  @override
  List<Object> get props => [state];
}
