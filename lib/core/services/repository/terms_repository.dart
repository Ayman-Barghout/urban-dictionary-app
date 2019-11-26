import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/models/terms.dart' as models;

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

  int getDaysDifference(DateTime viewed) =>
      DateTime.now().difference(viewed).inDays;

  Map<int, List<Term>> getTermsSeparatedbyDays(List<Term> terms) {
    int start = -1;
    int end = -1;
    int lastDay = 0;
    Map<int, List<Term>> termsWithDays = {};
    for (int i = 0; i < terms.length; i++) {
      int day = getDaysDifference(terms[i].lastViewed);
      if (!termsWithDays.containsKey(day)) {
        if (start < 0) {
          start = i;
          termsWithDays[day] = null;
          lastDay = day;
        } else {
          if (end < 0) {
            end = i;
            termsWithDays[lastDay] = terms.sublist(start, end);
            start = -1;
            end = -1;
          }
        }
      }
    }

    if (termsWithDays[getDaysDifference(terms[terms.length - 1].lastViewed)] ==
            null &&
        start > -1)
      termsWithDays[getDaysDifference(terms[terms.length - 1].lastViewed)] =
          terms.sublist(start);
    return termsWithDays;
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
