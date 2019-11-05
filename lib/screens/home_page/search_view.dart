import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/models/definitions_wrapper.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/services/db/database.dart';
import 'package:urban_dict_slang/widgets/definition_tile.dart';
import 'package:urban_dict_slang/widgets/header_appbar.dart';
import 'package:urban_dict_slang/widgets/rounded_search_field.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  void showAbout(BuildContext context) => showAboutDialog(
          context: context,
          applicationIcon: Image.asset('assets/icons/icon_sm.png'),
          applicationVersion: '1.0.3 (4)',
          applicationLegalese: 'Pocean Ltd.',
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Text('Programmer: Ayman Barghout'),
            SizedBox(
              height: 5.0,
            ),
            Text('Art designer: Hagar Blue Sea'),
            SizedBox(
              height: 5.0,
            ),
            Text('Reviewers: KhatibFX, Enie Yujo'),
          ]);

  @override
  Widget build(BuildContext context) {
    TermProvider termProvider = Provider.of<TermProvider>(context);
    DefinitionsProvider definitionsProvider =
        Provider.of<DefinitionsProvider>(context);

    Term term = termProvider.term ??
        Term(isFavorite: false, term: null, lastViewed: null);

    DefinitionsWrapper definitions = definitionsProvider.definitions ??
        DefinitionsWrapper([],
            'Search for a slang or a name, you can also view previous searches or favorited slangs');
    return Container(
      color: customStyles.primaryColorLight,
      padding: EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: HeaderAppBar(
              term: term.term,
              bookmarkIcon: term.isFavorite ? Icons.star : Icons.star_border,
              child: RoundedSearchField(onSearch: (String searchTerm) {
                termProvider.updateTerm(searchTerm);
                definitionsProvider.updateDefinitions(searchTerm);
              }),
              onBookmarkPress: () => termProvider.toggleFavorite(),
              onInfoButtonPress: () => showAbout(context),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
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
                child: Container(
                  child: definitionsProvider.loading ?? false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : definitions.definitions.length != 0
                          ? Scrollbar(
                              child: ListView.builder(
                                itemCount: definitions.definitions.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return DefinitionTile(
                                    definition: definitionsProvider
                                        .definitions.definitions[index],
                                    goToDefinition: (value) {
                                      termProvider.updateTerm(value);
                                      definitionsProvider
                                          .updateDefinitions(value);
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                definitions.message,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: customStyles.definitionTextStyle,
                              ),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
