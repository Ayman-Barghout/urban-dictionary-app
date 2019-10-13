import 'package:flutter/material.dart';

import 'package:urban_dict_slang/screens/result_page/result_page.dart';
import 'package:urban_dict_slang/models/definition.dart';

void main() => runApp(UrbanDictApp());

class UrbanDictApp extends StatelessWidget {
  const UrbanDictApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResultPage(
        potato: new Definition(
            'Potato is life', 15, 2, 'Ayman', 'Mashed potato is life sauce'),
      ),
    );
  }
}
