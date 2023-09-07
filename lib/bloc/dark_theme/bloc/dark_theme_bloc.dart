import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dark_theme_event.dart';
part 'dark_theme_state.dart';

class DarkThemeBloc extends Bloc<DarkThemeEvent, DarkThemeState> {
  DarkThemeBloc() : super(DarkThemeState(false)) {
    on<DarkThemeEvent>((event, emit) {});
    on<ToggleDarkTheme>((event, emit) {
      emit(DarkThemeState(!state.isDarkMode));
    });
  }
}
