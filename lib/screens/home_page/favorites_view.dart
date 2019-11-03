import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/favorites_provider.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoritesProvider termsProvider = Provider.of<FavoritesProvider>(context);
    return Container(
      color: customStyles.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Favorites',
                style: customStyles.termHeaderTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
              child: termsProvider.favorites == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : termsProvider.favorites.message == null
                      ? ListView.builder(
                          itemCount: termsProvider.favorites.terms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  termsProvider.favorites.terms[index].term),
                              trailing: Text(termsProvider
                                  .favorites.terms[index].lastViewed
                                  .toString()),
                            );
                          },
                        )
                      : Center(child: Text(termsProvider.favorites.message)),
            ),
          )
        ],
      ),
    );
  }
}
