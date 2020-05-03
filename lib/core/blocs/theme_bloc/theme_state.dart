part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => null;
}

class ThemeChanged extends ThemeState {
  final bool isDarkTheme;

  const ThemeChanged({this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}
