import 'package:flutter/material.dart';
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as app_colors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as text_styles;
//import './utilites.dart';

final ThemeData mainTheme = ThemeData(
  fontFamily: 'cairo',
  colorScheme: const ColorScheme.light(
    primary: app_colors.mainThemePrimaryColor,
    secondary: app_colors.mainThemeAccentColor,
  ),
  primaryColor: app_colors.mainThemePrimaryColor,
  cardColor: Colors.white,
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodySmall: text_styles.exampleStyle,
    labelSmall: text_styles.tapExampleStyle,
    bodyMedium: text_styles.definitionStyle,
    bodyLarge: text_styles.tapDefinitionStyle,
    titleLarge: text_styles.termHeaderStyle,
  ),
);

final ThemeData darkTheme = ThemeData(
  fontFamily: 'cairo',
  colorScheme: ColorScheme.dark(
    primary: app_colors.darkThemePrimaryColor,
    secondary: app_colors.darkThemeAccentColor,
    background: app_colors.darkThemeBackgroundColor,
  ),
  primaryColor: app_colors.darkThemePrimaryColor,
  cardColor: app_colors.darkThemeCardColor,
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: app_colors.darkThemeBackgroundColor,
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodySmall: text_styles.exampleStyleDark,
    labelSmall: text_styles.tapExampleStyleDark,
    bodyMedium: text_styles.definitionStyleDark,
    bodyLarge: text_styles.tapDefinitionStyleDark,
    titleLarge: text_styles.termHeaderStyleDark,
  ),
);
