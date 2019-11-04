import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/favorites_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/screens/home_page/home_page.dart';

import 'package:urban_dict_slang/screens/result_page/result_page.dart';
import 'package:urban_dict_slang/services/api/http_api.dart';
import 'package:urban_dict_slang/services/db/database.dart';
import 'package:urban_dict_slang/services/repository/definitions_repository.dart';
import 'package:urban_dict_slang/services/repository/term_repository.dart';
import 'package:urban_dict_slang/services/repository/terms_repository.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

void main() => runApp(UrbanDictApp());

class UrbanDictApp extends StatelessWidget {
  const UrbanDictApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      return MultiProvider(
        providers: [
          Provider.value(
            value: AppDatabase(),
          ),
          Provider.value(value: HttpApi()),
          ProxyProvider<AppDatabase, TermRepository>(
            builder: (_, db, repository) => TermRepository(db),
          ),
          ProxyProvider<AppDatabase, TermsRepository>(
            builder: (_, db, repository) => TermsRepository(db),
          ),
          ProxyProvider2<HttpApi, AppDatabase, DefinitionsRepository>(
            builder: (_, api, db, repository) => DefinitionsRepository(api, db),
          ),
          ChangeNotifierProxyProvider<TermRepository, TermProvider>(
            builder: (_, repository, term) => TermProvider(repository),
          ),
          ChangeNotifierProxyProvider<DefinitionsRepository,
              DefinitionsProvider>(
            builder: (_, repository, definitions) =>
                DefinitionsProvider(repository),
          ),
          ChangeNotifierProxyProvider<TermsRepository, TermsProvider>(
            builder: (_, repository, terms) => TermsProvider(repository),
          ),
          ChangeNotifierProxyProvider<TermsRepository, FavoritesProvider>(
            builder: (_, repository, favorites) =>
                FavoritesProvider(repository),
          ),
        ],
        child: MaterialApp(
          title: 'Urban Dictionary',
          theme: ThemeData(primaryColor: customStyles.primaryColor),
          routes: {
            '/': (context) => SplashScreen(
                  'assets/flare/splash.flr',
                  (context) => HomePage(),
                  startAnimation: 'intro',
                  until: () => Future.delayed(Duration(seconds: 3)),
                  backgroundColor: Colors.white,
                ),
            '/homepage': (context) => HomePage(),
            '/result': (context) => ResultPage()
          },
          initialRoute: '/',
        ),
      );
    });
  }
}
