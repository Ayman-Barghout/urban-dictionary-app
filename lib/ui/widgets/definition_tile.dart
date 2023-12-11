// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/ui/widgets/tappable_text.dart';

class DefinitionTile extends StatelessWidget {
  const DefinitionTile({
    super.key,
    required this.definition,
    required this.goToDefinition,
  });

  final Definition definition;
  final ValueChanged<String> goToDefinition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).colorScheme.background),
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
                  const Icon(
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
                  const Icon(
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
