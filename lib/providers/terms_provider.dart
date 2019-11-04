import 'package:flutter/material.dart';

import 'package:urban_dict_slang/models/terms.dart';
import 'package:urban_dict_slang/services/repository/terms_repository.dart';

class TermsProvider with ChangeNotifier {
  final TermsRepository repository;
  Terms _terms;
  bool _loading;

  TermsProvider(this.repository);

  void getTerms() async {
    loading = true;
    terms = await repository.getAllTerms();
    loading = false;
  }

  void deleteTerm(String term) async {
    await repository.deleteTerm(term);
  }

  Terms get terms => _terms;

  set terms(Terms newTerm) {
    _terms = newTerm;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
}
