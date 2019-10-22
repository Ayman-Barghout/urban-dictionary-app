import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/screens/home_page/home_page.dart';

import 'package:urban_dict_slang/screens/result_page/result_page.dart';

void main() => runApp(UrbanDictApp());

class UrbanDictApp extends StatelessWidget {
  const UrbanDictApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TermProvider>(
          builder: (context) => TermProvider('app'),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => HomePage(),
          '/result': (context) => ResultPage()
        },
        initialRoute: '/',
      ),
    );
  }
}
