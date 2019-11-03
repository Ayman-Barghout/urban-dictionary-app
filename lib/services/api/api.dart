import 'package:urban_dict_slang/services/db/database.dart';

abstract class Api {
  Future<List<Definition>> getDefinitions(String term);
}
