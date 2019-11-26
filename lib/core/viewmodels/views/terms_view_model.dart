import 'package:flutter/widgets.dart';
import 'package:urban_dict_slang/core/models/terms.dart' as model;
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';
import 'package:urban_dict_slang/core/viewmodels/base_model.dart';

class TermsViewModel extends BaseModel {
  TermsRepository _termsRepository;

  TermsViewModel({
    @required TermsRepository termsRepository,
  }) : _termsRepository = termsRepository;

  List<Term> terms;
  String message;

  Future fetchTerms() async {
    setBusy(true);
    model.Terms termsWrapper = await _termsRepository.getAllTerms();
    if (termsWrapper.message == null) {
      terms = termsWrapper.terms;
    } else {
      message = termsWrapper.message;
    }
    setBusy(false);
  }
}
