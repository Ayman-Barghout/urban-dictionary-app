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
      Term term = Term(
          term: 'Urban Dictionary',
          lastViewed: DateTime.now(),
          isFavorite: false);
      return term;
    }

    String modifiedTerm = passedTerm.toLowerCase().trim();
    Term term = await db.termDao.getTerm(modifiedTerm);
    List<Definition> definitions = await fetchDefinitions(passedTerm);
    if (term == null) {
      term = Term(
          term: passedTerm.toLowerCase().trim(),
          lastViewed: DateTime.now(),
          isFavorite: false);
      if (definitions == null) {
        return term;
      } else if (definitions.length == 0) {
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
    return await db.termDao.getTerm(passedTerm.term);
  }

  Future deleteTerm(String term) async {
    await db.termDao.deleteTerm(term);
  }

  Future<List<Definition>> _callApi(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();

    return await api.getDefinitions(modifiedTerm);
  }

  Future<List<Definition>> fetchDefinitions(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    List<Definition> dbDefinitions =
        await db.definitionsDao.getDefinitions(modifiedTerm);
    List<Definition> apiDefinitions = await _callApi(passedTerm);

    // No internet connection and no data in db
    if (apiDefinitions == null && dbDefinitions.length == 0) {
      return null;
    }
    // No internet connection and data found in db
    else if (apiDefinitions == null && dbDefinitions.length != 0) {
      return dbDefinitions;
    }
    // Connected but no data in api
    else if (apiDefinitions.length == 0) {
      return apiDefinitions;
    }
    // Connected but no data in db (inset new data into db)
    else if (dbDefinitions.length == 0) {
      await db.definitionsDao.insertDefinitions(modifiedTerm, apiDefinitions);
      return apiDefinitions;
    }
    // Connected and there is data in db (update data in db)
    else {
      await db.definitionsDao.deleteDefinitions(modifiedTerm);
      await db.definitionsDao.insertDefinitions(modifiedTerm, apiDefinitions);
      return apiDefinitions;
    }
  }
}
