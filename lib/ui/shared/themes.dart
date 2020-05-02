import 'package:flutter/material.dart';
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as appColors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
//import './utilites.dart';

final appThemes = [
  mainTheme,
  darkTheme,
];

final mainTheme = ThemeData(
  fontFamily: 'cairo',
  accentColor: appColors.mainThemeAccentColor,
  primaryColor: appColors.mainThemePrimaryColor,
  backgroundColor: Colors.white,
  cardColor: Colors.white,
  bottomAppBarColor: Colors.white,
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    caption: textStyles.exampleStyle,
    overline: textStyles.tapExampleStyle,
    body1: textStyles.definitionStyle,
    body2: textStyles.tapDefinitionStyle,
    headline: textStyles.termHeaderStyle,
  ),
);

final darkTheme = ThemeData(
  fontFamily: 'cairo',
  accentColor: appColors.darkThemeAccentColor,
  primaryColor: appColors.darkThemePrimaryColor,
  backgroundColor: appColors.darkThemeBackgroundColor,
  cardColor: appColors.darkThemeCardColor,
  bottomAppBarColor: Colors.white,
  disabledColor: Colors.grey,
  scaffoldBackgroundColor: appColors.darkThemeBackgroundColor,
  iconTheme: IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    elevation: 0,
  ),
  textTheme: TextTheme(
    caption: textStyles.exampleStyleDark,
    overline: textStyles.tapExampleStyleDark,
    body1: textStyles.definitionStyleDark,
    body2: textStyles.tapDefinitionStyleDark,
    headline: textStyles.termHeaderStyleDark,
  ),
);
