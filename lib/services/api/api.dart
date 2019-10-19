import 'package:urban_dict_slang/models/term.dart';

abstract class Api {
  Future<Term> getDefinitions(String term);
}
