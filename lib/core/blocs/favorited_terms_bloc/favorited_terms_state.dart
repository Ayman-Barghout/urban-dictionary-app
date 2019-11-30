import 'package:equatable/equatable.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class FavoritedTermsState extends Equatable {
  const FavoritedTermsState();
}

class InitialFavoritedTermsState extends FavoritedTermsState {
  @override
  List<Object> get props => [];
}

class FavoritedTermsLoading extends FavoritedTermsState {
  @override
  List<Object> get props => [];
}

class FavoritedTermsLoaded extends FavoritedTermsState {
  final List<Term> favorites;

  FavoritedTermsLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoritesEmpty extends FavoritedTermsState {
  final String message;

  FavoritesEmpty(this.message);
  @override
  List<Object> get props => [message];
}
