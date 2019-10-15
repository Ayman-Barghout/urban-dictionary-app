import 'package:urban_dict_slang/models/definition.dart';

abstract class Api {
  Future<List<Definition>> getDefinitions(String term);
}
