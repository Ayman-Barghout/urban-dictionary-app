import 'package:flutter/material.dart';
import 'package:urban_dict_slang/models/definitions_wrapper.dart';

import 'package:urban_dict_slang/services/repository/definitions_repository.dart';

class DefinitionsProvider with ChangeNotifier {
  final DefinitionsRepository repository;
  DefinitionsWrapper _definitions;
  bool _loading;

  DefinitionsProvider(this.repository);

  void updateDefinitions(String newTerm) async {
    loading = true;
    definitions = await repository.getTermDefinitions(newTerm);
    loading = false;
  }

  DefinitionsWrapper get definitions => _definitions;

  set definitions(DefinitionsWrapper definitions) {
    _definitions = definitions;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
}
