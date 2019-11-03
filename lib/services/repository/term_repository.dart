import 'package:urban_dict_slang/services/db/database.dart';

class TermRepository {
  final AppDatabase db;

  TermRepository(this.db);

  Future<Term> getTerm(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    Term term = await db.termDao.getTerm(modifiedTerm);
    if (term == null) {
      return Term(
          term: passedTerm.toLowerCase().trim(),
          lastViewed: DateTime.now(),
          isFavorite: false);
    } else {
      return term;
    }
  }

  Future updateLastViewed(Term term) => db.termDao.updateLastViewed(term);

  Future toggleFavorite(Term term) => db.termDao.toggleFavorite(term);
}
