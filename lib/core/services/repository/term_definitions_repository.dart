import 'dart:async';
import 'package:urban_dict_slang/core/models/definitions_wrapper.dart';
import 'package:urban_dict_slang/core/services/api/api.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

class TermDefinitionsRepository {
  final Api api;
  final AppDatabase db;

  TermDefinitionsRepository(this.db, this.api);

  StreamController<Term> _termController = StreamController<Term>();

  Stream<Term> get term => _termController.stream;

  Future<Term> updateTerm(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    Term term = await db.termDao.getTerm(modifiedTerm);
    if (term == null) {
      term = Term(
          term: passedTerm.toLowerCase().trim(),
          lastViewed: DateTime.now(),
          isFavorite: false);
      _termController.add(term);
      db.termDao.insertNewTerm(term.term);
      return term;
    } else {
      db.termDao.updateLastViewed(term);
      _termController.add(term);
      return term;
    }
  }

  Future toggleFavorite(Term passedTerm) async {
    await db.termDao.toggleFavorite(passedTerm);
    updateTerm(passedTerm.term);
    _termController.add(passedTerm);
  }

  Future deleteTerm(String passedTerm, String currentTerm) async {
    await db.termDao.deleteTerm(passedTerm);
    // In case user deletes the current term he is viewing
    if (passedTerm == currentTerm) {
      _termController.add(null);
    }
  }

  Future<DefinitionsWrapper> _callApi(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    String message;

    final List<Definition> definitions = await api.getDefinitions(modifiedTerm);
    if (definitions == null) {
      message = 'No internet connection, please try again';
      return DefinitionsWrapper(null, message);
    } else if (definitions.length == 0) {
      message = 'No such slang found, try another slang';
      return DefinitionsWrapper(null, message);
    } else {
      return DefinitionsWrapper(definitions, null);
    }
  }

  Future<DefinitionsWrapper> getTermDefinitions(String passedTerm) async {
    // For initial app start where string passed is empty
    if (passedTerm == '')
      return DefinitionsWrapper(
          null, 'Search for a slang or term to get its definitions');
    String modifiedTerm = passedTerm.toLowerCase().trim();
    List<Definition> definitions =
        await db.definitionsDao.getDefinitions(modifiedTerm);
    DefinitionsWrapper apiDefinitions = await _callApi(passedTerm);

    if (definitions.length == 0) {
      // Definitions not in DB, insert and return them
      if (apiDefinitions.definitions != null)
        await db.definitionsDao.insertDefinitions(modifiedTerm, definitions);
      return apiDefinitions;
    } else {
      if (apiDefinitions.definitions == null) {
        return DefinitionsWrapper(definitions, null);
      } else {
        await db.definitionsDao.updateDefinitions(modifiedTerm, definitions);
        return apiDefinitions;
      }
    }
  }
}
