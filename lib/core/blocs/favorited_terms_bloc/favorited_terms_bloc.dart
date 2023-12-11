import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';

class FavoritedTermsBloc
    extends Bloc<FavoritedTermsEvent, FavoritedTermsState> {
  final TermsRepository termsRepository;

  FavoritedTermsBloc(this.termsRepository)
      : super(InitialFavoritedTermsState()) {
    on<LoadFavoritedTerms>(
      (event, emit) async {
        emit(FavoritedTermsLoading());
        final List<Term> favorites = await termsRepository.getAllFavorites();
        if (favorites.isEmpty) {
          emit(
            const FavoritesEmpty(
              'No slangs favorited, favorite slangs to view them here',
            ),
          );
        } else {
          emit(FavoritedTermsLoaded(favorites));
        }
      },
    );
  }
}
