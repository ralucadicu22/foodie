part of 'dark_theme_bloc.dart';

class DarkThemeState extends Equatable {
  final bool isDarkMode;

  const DarkThemeState(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}
