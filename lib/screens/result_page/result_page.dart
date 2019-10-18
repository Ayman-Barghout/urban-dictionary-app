import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';

import 'package:urban_dict_slang/widgets/definition_tile.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;
import 'package:urban_dict_slang/widgets/rounded_header_appbar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key, this.passedTerm}) : super(key: key);

  final String passedTerm;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TermProvider>(
          builder: (context) => TermProvider(passedTerm),
        ),
      ],
      child: ResultPageBody(),
    );
  }
}

class ResultPageBody extends StatelessWidget {
  const ResultPageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TermProvider termProvider = Provider.of<TermProvider>(context);
    return Scaffold(
      appBar: RoundedBottomAppBar(
        bookmarkIcon: Icons.star_border,
        term: termProvider.term,
      ),
      body: termProvider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: termProvider.definitions.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return DefinitionTile(
                  definition: termProvider.definitions[index],
                  goToDefinition: termProvider.updateTerm,
                );
              },
            ),
    );
  }
}
