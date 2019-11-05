import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/definitions_provider.dart';
import 'package:urban_dict_slang/providers/favorites_provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/services/db/database.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key, this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context);
    TermProvider termProvider = Provider.of<TermProvider>(context);
    DefinitionsProvider definitionsProvider =
        Provider.of<DefinitionsProvider>(context);
    return Container(
      color: customStyles.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'Favorites',
                  style: customStyles.termHeaderTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: favoritesProvider.favorites == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : favoritesProvider.favorites.message == null
                      ? ListView.builder(
                          itemCount: favoritesProvider.favorites.terms.length,
                          itemBuilder: (BuildContext context, int index) {
                            Term favoriteTerm =
                                favoritesProvider.favorites.terms[index];
                            return ListTile(
                              onTap: () {
                                termProvider.updateTerm(favoriteTerm.term);
                                definitionsProvider
                                    .updateDefinitions(favoriteTerm.term);
                                changeIndex(1);
                              },
                              title: Text(
                                favoriteTerm.term != ''
                                    ? favoriteTerm.term[0].toUpperCase() +
                                        favoriteTerm.term.substring(1)
                                    : '',
                                style: customStyles.definitionTextStyle,
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: customStyles.primaryColorLight,
                                ),
                                onPressed: () {
                                  favoritesProvider
                                      .toggleFavorite(favoriteTerm);
                                  favoritesProvider.getFavorites();
                                  if (termProvider.term.term ==
                                      favoriteTerm.term) {
                                    termProvider.updateTerm(favoriteTerm.term);
                                  }
                                },
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(favoritesProvider.favorites.message)),
            ),
          )
        ],
      ),
    );
  }
}
