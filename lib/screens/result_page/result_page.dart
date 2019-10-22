import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';

import 'package:urban_dict_slang/widgets/definition_tile.dart';
import 'package:urban_dict_slang/widgets/rounded_header_appbar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key, this.passedTerm}) : super(key: key);

  final String passedTerm;

  @override
  Widget build(BuildContext context) {
    TermProvider termProvider = Provider.of<TermProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        shape: BeveledRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(200, 30))),
        bottom: RoundedHeaderAppBar(
          term: termProvider.term.term,
          bookmarkIcon: Icons.star_border,
          onSearch: (String searchTerm) {
            termProvider.updateTerm(searchTerm);
          },
          onBackbuttonPress: () => Navigator.of(context).pop(),
        ),
      ),
      body: termProvider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : termProvider.term.message == null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: termProvider.term.definitions.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return DefinitionTile(
                          definition: termProvider.term.definitions[index],
                          goToDefinition: termProvider.updateTerm,
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Text(termProvider.term.message),
                ),
    );
  }
}
