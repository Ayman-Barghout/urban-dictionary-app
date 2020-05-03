import 'dart:async';
import 'package:urban_dict_slang/core/services/api/api.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

class TermDefinitionsRepository {
  final Api api;
  final AppDatabase db;

  TermDefinitionsRepository(this.db, this.api);

  Future<Term> getTerm(String passedTerm) async {
    // In case user searches for empty text
    if (passedTerm == '') {
      final Term term = Term(
          term: 'Urban Dictionary',
          lastViewed: DateTime.now(),
          isFavorite: false);
      return term;
    }

    final String modifiedTerm = passedTerm.toLowerCase().trim();
    Term term = await db.termDao.getTerm(modifiedTerm);
    final List<Definition> definitions = await fetchDefinitions(passedTerm);
    if (term == null) {
      term = Term(
          term: passedTerm.toLowerCase().trim(),
          lastViewed: DateTime.now(),
          isFavorite: false);
      if (definitions == null) {
        return term;
      } else if (definitions.isEmpty) {
        return term;
      } else {
        await db.termDao.insertNewTerm(term.term);
        return term;
      }
    } else {
      db.termDao.updateLastViewed(term);
      return term;
    }
  }

  Future<Term> toggleFavorite(Term passedTerm) async {
    await db.termDao.toggleFavorite(passedTerm);
    return db.termDao.getTerm(passedTerm.term);
  }

  Future deleteTerm(String term) async {
    await db.termDao.deleteTerm(term);
  }

  Future<List<Definition>> _callApi(String passedTerm) async {
    final String modifiedTerm = passedTerm.toLowerCase().trim();

    return api.getDefinitions(modifiedTerm);
  }

  Future<List<Definition>> fetchDefinitions(String passedTerm) async {
    final String modifiedTerm = passedTerm.toLowerCase().trim();
    final List<Definition> dbDefinitions =
        await db.definitionsDao.getDefinitions(modifiedTerm);
    final List<Definition> apiDefinitions = await _callApi(passedTerm);

    // No internet connection and no data in db
    if (apiDefinitions == null && dbDefinitions.isEmpty) {
      return null;
    }
    // No internet connection and data found in db
    else if (apiDefinitions == null && dbDefinitions.isNotEmpty) {
      return dbDefinitions;
    }
    // Connected but no data in api
    else if (apiDefinitions.isEmpty) {
      return apiDefinitions;
    }
    // Connected and there is data in db (update data in db)
    else {
      await db.definitionsDao.insertDefinitions(modifiedTerm, apiDefinitions);
      return apiDefinitions;
    }
  }
}
