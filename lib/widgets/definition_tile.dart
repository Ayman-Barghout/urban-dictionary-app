import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/definition.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class DefinitionTile extends StatelessWidget {
  const DefinitionTile({Key key, this.definition}) : super(key: key);
  final Definition definition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.white),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            definition.definition.replaceAll(RegExp(r'[\[\]]'), ''),
            style: customStyles.definitionTextStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            definition.example.replaceAll(RegExp(r'[\[\]]'), ''),
            style: customStyles.exampleTextStyle,
          ),
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
                    '~ ${definition.author}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  Text(
                    definition.thumbsUp.toString(),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  Text(
                    definition.thumbsDown.toString(),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
