import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';

import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';

import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;

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
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: BlocBuilder<FavoritedTermsBloc, FavoritedTermsState>(
                  builder: (context, state) {
                    if (state is FavoritedTermsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FavoritesEmpty) {
                      return Center(
                        child: Text(
                          state.message,
                          style: textStyles.definitionStyle,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      );
                    } else if (state is FavoritedTermsLoaded) {
                      return ListView.builder(
                        itemCount: state.favorites.length,
                        itemBuilder: (BuildContext context, int index) {
                          Term favoriteTerm = state.favorites[index];
                          return ListTile(
                            onTap: () {
                              BlocProvider.of<TermBloc>(context).add(
                                ChangeTerm(newTerm: favoriteTerm.term),
                              );
                              BlocProvider.of<DefinitionsBloc>(context)
                                  .add(FetchDefinitions(favoriteTerm.term));
                              changeIndex(1);
                            },
                            title: Text(
                              favoriteTerm.term[0].toUpperCase() +
                                  favoriteTerm.term.substring(1),
                              style: textStyles.definitionStyle,
                            ),
                            trailing: BlocBuilder<TermBloc, TermState>(
                                builder: (context, state) {
                              Function _onPressed = () {};
                              Future _toggleWithoutChanging() async {
                                await RepositoryProvider.of<
                                        TermDefinitionsRepository>(context)
                                    .toggleFavorite(favoriteTerm);
                                BlocProvider.of<FavoritedTermsBloc>(context)
                                    .add(LoadFavoritedTerms());
                              }

                              if (state is TermChanged) {
                                _onPressed = () async {
                                  if (favoriteTerm.term == state.term.term) {
                                    _toggleWithoutChanging();
                                    BlocProvider.of<TermBloc>(context).add(
                                        ChangeTerm(newTerm: favoriteTerm.term));
                                  } else {
                                    _toggleWithoutChanging();
                                  }
                                };
                              } else {
                                _onPressed = _toggleWithoutChanging;
                              }
                              return IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: customColors.primaryColorLight,
                                ),
                                onPressed: _onPressed,
                              );
                            }),
                          );
                        },
                      );
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
