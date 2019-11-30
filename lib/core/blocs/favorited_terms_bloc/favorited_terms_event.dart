import 'package:equatable/equatable.dart';

abstract class FavoritedTermsEvent extends Equatable {
  const FavoritedTermsEvent();
}

class LoadFavoritedTerms extends FavoritedTermsEvent {
  @override
  List<Object> get props => [];
}
