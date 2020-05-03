import 'package:flutter/material.dart';
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as app_colors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as text_styles;
//import './utilites.dart';

final ThemeData mainTheme = ThemeData(
  fontFamily: 'cairo',
  accentColor: app_colors.mainThemeAccentColor,
  primaryColor: app_colors.mainThemePrimaryColor,
  backgroundColor: Colors.white,
  cardColor: Colors.white,
  bottomAppBarColor: Colors.white,
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    caption: text_styles.exampleStyle,
    overline: text_styles.tapExampleStyle,
    body1: text_styles.definitionStyle,
    body2: text_styles.tapDefinitionStyle,
    headline: text_styles.termHeaderStyle,
  ),
);

final ThemeData darkTheme = ThemeData(
  fontFamily: 'cairo',
  accentColor: app_colors.darkThemeAccentColor,
  primaryColor: app_colors.darkThemePrimaryColor,
  backgroundColor: app_colors.darkThemeBackgroundColor,
  cardColor: app_colors.darkThemeCardColor,
  bottomAppBarColor: Colors.white,
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: app_colors.darkThemeBackgroundColor,
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    caption: text_styles.exampleStyleDark,
    overline: text_styles.tapExampleStyleDark,
    body1: text_styles.definitionStyleDark,
    body2: text_styles.tapDefinitionStyleDark,
    headline: text_styles.termHeaderStyleDark,
  ),
);
