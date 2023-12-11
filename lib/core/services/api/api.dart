import 'package:urban_dict_slang/core/services/db/database.dart';

abstract class Api {
  Future<List<Definition>?> getDefinitions(String term);
}
