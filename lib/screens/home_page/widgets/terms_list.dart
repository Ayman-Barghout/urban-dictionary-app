import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:urban_dict_slang/models/definitions_wrapper.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/services/db/database.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class TermsListWithHeaders extends StatelessWidget {
  final Function changeIndex;

  const TermsListWithHeaders({Key key, this.changeIndex}) : super(key: key);

  int getDaysDifference(DateTime viewed) =>
      DateTime.now().difference(viewed).inDays;

  Map<int, List<Term>> getTermsSeparatedbyDays(List<Term> terms) {
    int start = -1;
    int end = -1;
    int lastDay = 0;
    Map<int, List<Term>> termsWithDays = {};
    for (int i = 0; i < terms.length; i++) {
      int day = getDaysDifference(terms[i].lastViewed);
      if (!termsWithDays.containsKey(day)) {
        if (start < 0) {
          start = i;
          termsWithDays[day] = null;
          lastDay = day;
        } else {
          if (end < 0) {
            end = i;
            termsWithDays[lastDay] = terms.sublist(start, end);
            start = -1;
            end = -1;
          }
        }
      }
    }
    print(termsWithDays);
    if (termsWithDays[getDaysDifference(terms[terms.length - 1].lastViewed)] ==
            null &&
        start > 0)
      termsWithDays[getDaysDifference(terms[terms.length - 1].lastViewed)] =
          terms.sublist(start);
    print(termsWithDays);
    return termsWithDays;
  }

  @override
  Widget build(BuildContext context) {
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    TermProvider termProvider = Provider.of<TermProvider>(context);
    DefinitionsProvider definitionsProvider =
        Provider.of<DefinitionsProvider>(context);
    Map<int, List<Term>> termsWithDays =
        getTermsSeparatedbyDays(termsProvider.terms.terms);

    List<int> days = termsWithDays.keys.toList();
    List<List<Term>> termsList = termsWithDays.values.toList();

    print(days);
    print(termsList);

    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) {
        List<Widget> termsWidgets = termsList[index]
            .map((term) => TermListTile(
                changeIndex: changeIndex,
                termProvider: termProvider,
                currentTerm: term,
                definitionsProvider: definitionsProvider,
                termsProvider: termsProvider))
            .toList();
        return StickyHeader(
          header: Container(
            width: double.infinity,
            child: Text(
              days[index] > 1
                  ? '${days[index]} days ago'
                  : days[index] == 0 ? 'Today' : 'Yesterday',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: customStyles.primaryColorLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
          ),
          content: Column(
            children: termsWidgets,
          ),
        );
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
    this.changeIndex,
  }) : super(key: key);

  final TermProvider termProvider;
  final Term currentTerm;
  final DefinitionsProvider definitionsProvider;
  final TermsProvider termsProvider;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        termProvider.updateTerm(currentTerm.term);
        definitionsProvider.updateDefinitions(currentTerm.term);
        changeIndex(1);
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
          if (termProvider.term.term == currentTerm.term) {
            termProvider.term =
                Term(isFavorite: false, lastViewed: null, term: null);
          }
          definitionsProvider.definitions = DefinitionsWrapper([],
              'Search for a slang or a name, you can also view previous searches or favorited slangs');
        },
      ),
    );
  }
}
