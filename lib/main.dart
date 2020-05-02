import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/blocs_setup.dart';
import 'package:urban_dict_slang/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:urban_dict_slang/ui/shared/themes.dart';
import 'package:urban_dict_slang/ui/views/home_page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiRepositoryProvider(
    providers: repositoryProviders,
    child: MultiBlocProvider(
      providers: blocProviders,
      child: UrbanDictApp(),
    ),
  ));
}

class UrbanDictApp extends StatelessWidget {
  const UrbanDictApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is ThemeInitial) {
          BlocProvider.of<ThemeBloc>(context).add(InitiateTheme());
        }
      },
      builder: (context, state) => MaterialApp(
        title: 'Urban Dictionary',
        theme: mainTheme,
        themeMode: state is ThemeInitial
            ? ThemeMode.system
            : state is ThemeChanged && state.isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
        darkTheme: darkTheme,
        routes: {
          '/': (context) => SplashScreen(
                'assets/flare/splash.flr',
                (context) => HomePage(),
                startAnimation: 'intro',
                until: () => Future.delayed(Duration(seconds: 3)),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
          '/homepage': (context) => HomePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
