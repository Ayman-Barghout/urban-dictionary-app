import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/services/db/database.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class TermsListWithHeaders extends StatelessWidget {
  int getDaysDifference(DateTime viewed) =>
      DateTime.now().difference(viewed).inDays;

  @override
  Widget build(BuildContext context) {
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    TermProvider termProvider = Provider.of<TermProvider>(context);
    DefinitionsProvider definitionsProvider =
        Provider.of<DefinitionsProvider>(context);
    List<int> _days = [];

    return ListView.builder(
      itemCount: termsProvider.terms.terms.length,
      itemBuilder: (BuildContext context, int index) {
        Term currentTerm = termsProvider.terms.terms[index];
        int daysDifference = getDaysDifference(currentTerm.lastViewed);
        if (!_days.contains(daysDifference)) {
          _days.add(daysDifference);
          index--;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: customStyles.primaryColorLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  daysDifference > 1
                      ? '$daysDifference days ago'
                      : daysDifference == 0 ? 'Today' : 'Yesterday',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              TermListTile(
                  termProvider: termProvider,
                  currentTerm: currentTerm,
                  definitionsProvider: definitionsProvider,
                  termsProvider: termsProvider)
            ],
          );
        } else {
          return TermListTile(
              termProvider: termProvider,
              currentTerm: currentTerm,
              definitionsProvider: definitionsProvider,
              termsProvider: termsProvider);
        }
      },
    );
  }
}

class TermListTile extends StatelessWidget {
  const TermListTile({
    Key key,
    @required this.termProvider,
    @required this.currentTerm,
    @required this.definitionsProvider,
    @required this.termsProvider,
  }) : super(key: key);

  final TermProvider termProvider;
  final Term currentTerm;
  final DefinitionsProvider definitionsProvider;
  final TermsProvider termsProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        termProvider.updateTerm(currentTerm.term);
        definitionsProvider.updateDefinitions(currentTerm.term);
        var nav = await Navigator.of(context).pushNamed('/result');
        if (nav == true || nav == null) {
          termsProvider.getTerms();
        }
      },
      title: Text(
        currentTerm.term[0].toUpperCase() + currentTerm.term.substring(1),
        style: customStyles.definitionTextStyle,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          termsProvider.deleteTerm(currentTerm.term);
          termsProvider.getTerms();
        },
      ),
    );
  }
}
