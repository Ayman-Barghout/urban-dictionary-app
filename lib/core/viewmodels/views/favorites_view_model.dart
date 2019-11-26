import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/models/terms.dart' as model;
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class FavoritesViewModel extends BaseModel {
  TermsRepository _termsRepository;

  FavoritesViewModel({
    @required TermsRepository termsRepository,
  }) : _termsRepository = termsRepository;

  List<Term> favorites;
  String message;

  Future fetchFavorites() async {
    setBusy(true);
    model.Terms terms = await _termsRepository.getAllFavorites();
    if (terms.message == null) {
      favorites = terms.terms;
    } else {
      message = terms.message;
    }
    setBusy(false);
  }
}
