import 'package:flutter/material.dart';

import 'package:urban_dict_slang/widgets/definition_tile.dart';
import 'package:urban_dict_slang/models/definition.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key, this.potato}) : super(key: key);

  final Definition potato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DefinitionTile(
              definition: potato,
            ),
            DefinitionTile(
              definition: potato,
            ),
            DefinitionTile(
              definition: potato,
            ),
          ],
        ),
      ),
    );
  }
}
