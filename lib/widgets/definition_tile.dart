import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/definition.dart';

class DefinitionTile extends StatelessWidget {
  const DefinitionTile({Key key, this.definition}) : super(key: key);
  final Definition definition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.white),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(definition.definition),
          Text('Example:'),
          Text(definition.example),
          SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    definition.author,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_up, color: Colors.green),
                  Text(definition.thumbsUp.toString()),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.red,
                  ),
                  Text(definition.thumbsDown.toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
