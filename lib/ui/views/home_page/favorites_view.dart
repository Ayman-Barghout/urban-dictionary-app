import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/viewmodels/views/favorites_view_model.dart';
import 'package:urban_dict_slang/core/viewmodels/widgets/favorite_button_model.dart';
import 'package:urban_dict_slang/core/viewmodels/widgets/terms_tile_model.dart';

import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;

import '../base_widget.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key, this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customColors.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'Favorites',
                  style: textStyles.termHeaderStyle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: BaseWidget<FavoritesViewModel>(
              model: FavoritesViewModel(termsRepository: Provider.of(context)),
              onModelReady: (model) => model.fetchFavorites(),
              builder: (context, model, child) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: model.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : model.message == null
                        ? ListView.builder(
                            itemCount: model.favorites.length,
                            itemBuilder: (BuildContext context, int index) {
                              Term favoriteTerm = model.favorites[index];
                              return BaseWidget<TermsTileModel>(
                                model: TermsTileModel(
                                    termRepository: Provider.of(context)),
                                builder: (context, termModel, child) =>
                                    ListTile(
                                  onTap: () {
                                    termModel.updateTerm(favoriteTerm.term);
                                    changeIndex(1);
                                  },
                                  title: Text(
                                    favoriteTerm.term[0].toUpperCase() +
                                        favoriteTerm.term.substring(1),
                                    style: textStyles.definitionStyle,
                                  ),
                                  trailing: BaseWidget<FavoriteButtonModel>(
                                    model: FavoriteButtonModel(
                                        termRepository: Provider.of(context)),
                                    builder: (context, buttonModel, child) =>
                                        IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: customColors.primaryColorLight,
                                      ),
                                      onPressed: () {
                                        buttonModel
                                            .toggleFavorite(favoriteTerm);
                                        model.fetchFavorites();
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Text(model.message)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
