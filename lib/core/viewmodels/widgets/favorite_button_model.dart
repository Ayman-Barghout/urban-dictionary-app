import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class FavoriteButtonModel extends BaseModel {
  TermDefinitionsRepository _termRepository;

  FavoriteButtonModel({
    @required TermDefinitionsRepository termRepository,
  }) : _termRepository = termRepository;

  Future toggleFavorite(Term term) async {
    setBusy(true);
    await _termRepository.toggleFavorite(term);
    setBusy(false);
  }
}
