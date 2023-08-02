import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarState()) {
    on<NavbarEvent>((event, emit) {});
    on<ChangePage>((event, emit) {
      emit(NavbarState(state: event.page));
    });
  }
}
