import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/term.dart';
import 'package:urban_dict_slang/services/api/http_api.dart';

class TermProvider with ChangeNotifier {
  Term _term;
  bool _loading;

  TermProvider(String passedTerm) {
    updateTerm(passedTerm);
  }

  void updateTerm(String newTerm) async {
    loading = true;
    term = await HttpApi().getDefinitions(newTerm);
    loading = false;
  }

  Term get term => _term;

  set term(Term newTerm) {
    _term = newTerm;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
}
