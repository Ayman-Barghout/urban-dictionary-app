import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<InitiateTheme>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final isDark = prefs.getBool('isDarkTheme') ?? false;

        emit(ThemeChanged(isDarkTheme: isDark));
        prefs.setBool('isDarkTheme', isDark);
      },
    );

    on<ToggleTheme>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final isDark = prefs.getBool('isDarkTheme') ?? false;
        prefs.setBool('isDarkTheme', !isDark);
        emit(ThemeChanged(isDarkTheme: !isDark));
      },
    );
  }
}
