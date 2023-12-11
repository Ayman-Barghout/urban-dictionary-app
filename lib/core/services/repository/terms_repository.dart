import 'package:urban_dict_slang/core/services/db/database.dart';

class TermsRepository {
  final AppDatabase db;

  TermsRepository(this.db);

  Future<List<Term>> getAllTerms() async {
    return db.termDao.getAllTerms();
  }

  int _getDaysDifference(DateTime viewed) =>
      DateTime.now().difference(viewed).inDays;

  Map<int, List<Term>> getTermsHistory(List<Term> terms) {
    int start = -1;
    int end = -1;
    int lastDay = 0;
    final Map<int, List<Term>> termsWithDays = {};
    for (int i = 0; i < terms.length; i++) {
      final int day = _getDaysDifference(terms[i].lastViewed);
      if (!termsWithDays.containsKey(day)) {
        if (start < 0) {
          start = i;
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

    if (termsWithDays[_getDaysDifference(terms[terms.length - 1].lastViewed)] ==
            null &&
        start > -1) {
      termsWithDays[_getDaysDifference(terms[terms.length - 1].lastViewed)] =
          terms.sublist(start);
    }

    return termsWithDays;
  }

  Future<List<Term>> getAllFavorites() async {
    return db.termDao.getAllFavorites();
  }
}
