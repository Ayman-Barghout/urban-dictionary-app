import 'package:flutter/material.dart';
import 'package:urban_dict_slang/services/db/database.dart';

import 'package:urban_dict_slang/services/repository/term_repository.dart';

class TermProvider with ChangeNotifier {
  final TermRepository repository;
  Term _term;

  TermProvider(this.repository);

  void updateTerm(String newTerm) async {
    term = Term(term: '...', isFavorite: false, lastViewed: DateTime.now());
    term = await repository.getTerm(newTerm);
  }

  void toggleFavorite() async {
    await repository.toggleFavorite(term);
    term = await repository.getTerm(term.term);
  }

  Term get term => _term;

  set term(Term newTerm) {
    _term = newTerm;
    notifyListeners();
  }
}
