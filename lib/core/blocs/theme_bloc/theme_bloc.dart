import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitial();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDarkTheme');

    if (event is InitiateTheme) {
      if (isDark == null) {
        yield const ThemeChanged(isDarkTheme: false);
        prefs.setBool('isDarkTheme', false);
      } else {
        yield ThemeChanged(isDarkTheme: isDark);
      }
    }
    if (event is ToggleTheme) {
      prefs.setBool('isDarkTheme', !isDark);
      yield ThemeChanged(isDarkTheme: !isDark);
    }
  }
}
