import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/definition.dart';

class DefinitionTile extends StatelessWidget {
  const DefinitionTile({Key key, this.definition}) : super(key: key);
  final Definition definition;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(children: <Widget>[
          Text('Definition:'),
          Text(definition.definition),
          Text('Example:'),
          Text(definition.example),
          Text('Author: ${definition.author}'),
        ],),
      ),
    );
  }
}
