import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/terms.dart';
import 'package:urban_dict_slang/services/db/database.dart' as db;
import 'package:urban_dict_slang/services/repository/terms_repository.dart';

class FavoritesProvider with ChangeNotifier {
  final TermsRepository repository;
  Terms _favorites;
  bool _loading;

  FavoritesProvider(this.repository);

  void getFavorites() async {
    loading = true;
    favorites = await repository.getAllFavorites();
    loading = false;
  }

  void toggleFavorite(db.Term term) async {
    await repository.toggleFavorite(term);
  }

  Terms get favorites => _favorites;

  set favorites(Terms newTerm) {
    _favorites = newTerm;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
}
