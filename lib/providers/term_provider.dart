import 'package:flutter/foundation.dart';

import 'package:urban_dict_slang/models/definition.dart';
import 'package:urban_dict_slang/services/api/http_api.dart';

class TermProvider with ChangeNotifier {
  String _term;
  List<Definition> _definitions;
  bool _loading;

  TermProvider(String passedTerm) {
    term = passedTerm;
    updateTerm(term);
  }

  void updateTerm(String newTerm) async {
    term = newTerm;
    loading = true;
    definitions = await HttpApi().getDefinitions(term);
    loading = false;
  }

  List<Definition> get definitions => _definitions;

  set definitions(List<Definition> newDefinitions) {
    _definitions = newDefinitions;
    notifyListeners();
  }

  String get term => _term;

  set term(String newTerm) {
    _term = newTerm;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
}
