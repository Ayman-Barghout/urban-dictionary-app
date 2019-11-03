import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';

import 'package:urban_dict_slang/widgets/definition_tile.dart';
import 'package:urban_dict_slang/widgets/header_appbar.dart';
import 'package:urban_dict_slang/widgets/rounded_search_field.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class ResultPage extends StatelessWidget {
  const ResultPage({Key key, this.passedTerm}) : super(key: key);

  final String passedTerm;

  @override
  Widget build(BuildContext context) {
    TermProvider termProvider = Provider.of<TermProvider>(context);
    DefinitionsProvider definitionsProvider =
        Provider.of<DefinitionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customStyles.primaryColorLight,
        bottom: HeaderAppBar(
          term: termProvider.term.term,
          bookmarkIcon:
              termProvider.term.isFavorite ? Icons.star : Icons.star_border,
          child: RoundedSearchField(onSearch: (String searchTerm) {
            termProvider.updateTerm(searchTerm);
            definitionsProvider.updateDefinitions(searchTerm);
          }),
          onBookmarkPress: () => termProvider.toggleFavorite(),
          onBackbuttonPress: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: customStyles.primaryColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: definitionsProvider.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : definitionsProvider.definitions.definitions.length != 0
                  ? Scrollbar(
                      child: ListView.builder(
                        itemCount: definitionsProvider
                                .definitions.definitions.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          return DefinitionTile(
                            definition: definitionsProvider
                                .definitions.definitions[index],
                            goToDefinition: (value) {
                              termProvider.updateTerm(value);
                              definitionsProvider.updateDefinitions(value);
                            },
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(definitionsProvider.definitions.message),
                    ),
        ),
      ),
    );
  }
}
