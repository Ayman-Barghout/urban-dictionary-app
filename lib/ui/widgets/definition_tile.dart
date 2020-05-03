import 'package:flutter/material.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/ui/widgets/tappable_text.dart';

class DefinitionTile extends StatelessWidget {
  const DefinitionTile({Key key, this.definition, this.goToDefinition})
      : super(key: key);

  final Definition definition;
  final Function goToDefinition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).backgroundColor),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TappableText(
              rawText: definition.definition,
              onTap: goToDefinition,
              type: 'definition'),
          const SizedBox(
            height: 10.0,
          ),
          TappableText(
            rawText: definition.example,
            onTap: goToDefinition,
            type: 'example',
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    '~ ${definition.author}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
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
                    style: const TextStyle(fontSize: 16.0),
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
                    style: const TextStyle(fontSize: 16.0),
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
