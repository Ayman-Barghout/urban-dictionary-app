import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';

import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key, required this.changeIndex});

  final ValueChanged<int> changeIndex;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: BlocBuilder<FavoritedTermsBloc, FavoritedTermsState>(
                builder: (context, state) {
                  if (state is FavoritedTermsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.background ==
                                  Colors.white
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    );
                  } else if (state is FavoritesEmpty) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    );
                  } else if (state is FavoritedTermsLoaded) {
                    return ListView.builder(
                      itemCount: state.favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Term favoriteTerm = state.favorites[index];
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: BlocBuilder<TermBloc, TermState>(
                            builder: (context, state) {
                              VoidCallback onPressed = () {};
                              Future toggleWithoutChanging() async {
                                await RepositoryProvider.of<
                                        TermDefinitionsRepository>(context)
                                    .toggleFavorite(favoriteTerm);
                                if (!context.mounted) return;
                                BlocProvider.of<FavoritedTermsBloc>(context)
                                    .add(LoadFavoritedTerms());
                              }

                              if (state is TermChanged) {
                                onPressed = () async {
                                  if (favoriteTerm.term == state.term.term) {
                                    toggleWithoutChanging();
                                    BlocProvider.of<TermBloc>(context).add(
                                      ChangeTerm(
                                        newTerm: favoriteTerm.term,
                                      ),
                                    );
                                  } else {
                                    toggleWithoutChanging();
                                  }
                                };
                              } else {
                                onPressed = toggleWithoutChanging;
                              }
                              return IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: Theme.of(context)
                                              .colorScheme
                                              .background ==
                                          Colors.white
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  onPressed();
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.background ==
                                  Colors.white
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
