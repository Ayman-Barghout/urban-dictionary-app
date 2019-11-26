import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/models/definitions_wrapper.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class SearchViewModel extends BaseModel {
  TermDefinitionsRepository _termDefinitionsRepository;

  SearchViewModel({
    @required TermDefinitionsRepository termDefinitionsRepository,
  }) : _termDefinitionsRepository = termDefinitionsRepository;

  String message;
  List<Definition> definitions;

  Future fetchDefinitions(String term) async {
    setBusy(true);
    DefinitionsWrapper definitionsWrapper =
        await _termDefinitionsRepository.getTermDefinitions(term);
    if (definitionsWrapper.message == null) {
      definitions = definitionsWrapper.definitions;
      message = definitionsWrapper.message;
    } else {
      definitions = definitionsWrapper.definitions;
      message = definitionsWrapper.message;
    }
    setBusy(false);
  }

  Future updateTermAndDefinitions(String term) async {
    setBusy(true);
    await _termDefinitionsRepository.updateTerm(term);
    fetchDefinitions(term);
    setBusy(false);
  }
}
