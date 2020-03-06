import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/provider_setup.dart';
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as appColors;
import 'package:urban_dict_slang/ui/views/home_page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(UrbanDictApp());
}

class UrbanDictApp extends StatelessWidget {
  const UrbanDictApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp(
          title: 'Urban Dictionary',
          theme: ThemeData(primaryColor: appColors.primaryColor),
          routes: {
            '/': (context) => SplashScreen(
                  'assets/flare/splash.flr',
                  (context) => HomePage(),
                  startAnimation: 'intro',
                  until: () => Future.delayed(Duration(seconds: 3)),
                  backgroundColor: Colors.white,
                ),
            '/homepage': (context) => HomePage(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}
