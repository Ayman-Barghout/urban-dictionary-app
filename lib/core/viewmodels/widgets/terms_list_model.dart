import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/models/terms.dart' as model;
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class TermsListModel extends BaseModel {
  TermsRepository _termsRepository;

  TermsListModel({
    @required TermsRepository termsRepository,
  }) : _termsRepository = termsRepository;

  Map<int, List<Term>> definitionsWithDates;
  String message;

  Future getTermsWithDays() async {
    setBusy(true);
    model.Terms terms = await _termsRepository.getAllTerms();
    if (terms.terms != null) {
      definitionsWithDates =
          _termsRepository.getTermsSeparatedbyDays(terms.terms);
      message = terms.message;
    } else {
      message = terms.message;
      definitionsWithDates = null;
    }
    setBusy(false);
  }
}
