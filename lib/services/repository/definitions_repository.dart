import 'package:urban_dict_slang/models/definitions_wrapper.dart';
import 'package:urban_dict_slang/services/api/http_api.dart';
import 'package:urban_dict_slang/services/db/database.dart';

class DefinitionsRepository {
  final HttpApi httpApi;
  final AppDatabase db;

  DefinitionsRepository(this.httpApi, this.db);

  Future<DefinitionsWrapper> _callApi(
      Term term, String passedTerm, bool outdated) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    String message;

    final List<Definition> definitions =
        await httpApi.getDefinitions(modifiedTerm);
    if (definitions == null) {
      message = 'No internet connection, please try again';
      return DefinitionsWrapper([], message);
    } else if (definitions.length == 0) {
      message = 'No such slang found, try another slang';
      return DefinitionsWrapper([], message);
    } else {
      if (term != null || outdated) {
        await db.termDao.updateLastViewed(term);
        await db.definitionsDao.updateDefinitions(modifiedTerm, definitions);
      } else {
        await db.termDao.insertNewTerm(modifiedTerm);
        await db.definitionsDao.insertDefinitions(modifiedTerm, definitions);
      }
      return DefinitionsWrapper(definitions, null);
    }
  }

  Future<DefinitionsWrapper> getTermDefinitions(String passedTerm) async {
    String modifiedTerm = passedTerm.toLowerCase().trim();
    Term term = await db.termDao.getTerm(modifiedTerm);
    if (term == null) {
      return await _callApi(term, modifiedTerm, false);
    } else {
      if (DateTime.now().difference(term.lastViewed).inDays > 5) {
        return await _callApi(term, modifiedTerm, true);
      } else {
        List<Definition> definitions =
            await db.definitionsDao.getDefinitions(modifiedTerm);
        await db.termDao.updateLastViewed(term);
        return DefinitionsWrapper(definitions, null);
      }
    }
  }

  Future updateLastViewed(Term term) => db.termDao.updateLastViewed(term);

  Future toggleFavorite(Term term) => db.termDao.toggleFavorite(term);
}
