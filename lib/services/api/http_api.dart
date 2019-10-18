import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:urban_dict_slang/models/definition.dart';
import 'package:urban_dict_slang/services/api/api.dart';

class HttpApi implements Api {
  static const String URL_PATH =
      'http://api.urbandictionary.com/v0/define?term=';

  @override
  Future<List<Definition>> getDefinitions(String term) async {
    http.Response response = await http.get(URL_PATH + term);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> definitionsList = body['list'];
      List<Definition> definitions = List<Definition>();

      for (Map<String, dynamic> json in definitionsList) {
        definitions.add(Definition.fromJson(json));
      }

      return definitions;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
