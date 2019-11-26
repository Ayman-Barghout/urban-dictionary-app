import 'package:flutter/material.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/widgets/definition_tile.dart';

class DefinitionsList extends StatelessWidget {
  final bool isBusy;
  final List<Definition> definitions;
  final String message;
  final Function onTextTap;

  const DefinitionsList({
    Key key,
    @required this.isBusy,
    @required this.definitions,
    @required this.message,
    @required this.onTextTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : message == null
            ? Scrollbar(
                child: ListView.builder(
                  itemCount: definitions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DefinitionTile(
                      definition: definitions[index],
                      goToDefinition: (value) => onTextTap(value),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: textStyles.definitionStyle,
                ),
              );
  }
}
