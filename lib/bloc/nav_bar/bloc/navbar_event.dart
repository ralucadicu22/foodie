part of 'navbar_bloc.dart';

class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class ChangePage extends NavbarEvent {
  final NavBarStateEnum page;

  ChangePage(this.page);
}
