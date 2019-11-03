import 'package:urban_dict_slang/models/terms.dart' as models;
import 'package:urban_dict_slang/services/db/database.dart';

class TermsRepository {
  final AppDatabase db;

  TermsRepository(this.db);

  Future<models.Terms> getAllTerms() async {
    List<Term> terms = await db.termDao.getAllTerms();
    if (terms == null || terms.length == 0) {
      return models.Terms(null, 'No slangs found, try to search some more');
    } else {
      return models.Terms(terms, null);
    }
  }

  Future<models.Terms> getAllFavorites() async {
    List<Term> favorites = await db.termDao.getAllFavorites();
    if (favorites == null || favorites.length == 0) {
      return models.Terms(null, 'You have\'t favorited any slangs yet!');
    } else {
      return models.Terms(favorites, null);
    }
  }
}
