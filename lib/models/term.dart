import 'package:urban_dict_slang/models/definition.dart';

class Term {
  final String term;
  final List<Definition> definitions;
  final String message;

  Term(this.term, this.definitions, this.message);
}
