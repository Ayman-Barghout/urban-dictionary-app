import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class TermsTileModel extends BaseModel {
  TermDefinitionsRepository _termRepository;

  TermsTileModel({
    @required TermDefinitionsRepository termRepository,
  }) : _termRepository = termRepository;

  Future deleteTerm(String term, String currentTerm) async {
    setBusy(true);
    await _termRepository.deleteTerm(term, currentTerm);
    setBusy(false);
  }

  Future updateTerm(String term) async {
    setBusy(true);
    await _termRepository.updateTerm(term);
    setBusy(false);
  }
}
