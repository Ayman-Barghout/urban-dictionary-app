import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';
import './bloc.dart';

class FavoritedTermsBloc
    extends Bloc<FavoritedTermsEvent, FavoritedTermsState> {
  final TermsRepository termsRepository;

  FavoritedTermsBloc(this.termsRepository);

  @override
  FavoritedTermsState get initialState => InitialFavoritedTermsState();

  @override
  Stream<FavoritedTermsState> mapEventToState(
    FavoritedTermsEvent event,
  ) async* {
    if (event is LoadFavoritedTerms) {
      yield FavoritedTermsLoading();
      List<Term> favorites = await termsRepository.getAllFavorites();
      if (favorites.length == 0) {
        yield FavoritesEmpty(
            'No slangs favorited, favorite slangs to view them here');
      } else {
        yield FavoritedTermsLoaded(favorites);
      }
    }
  }
}
