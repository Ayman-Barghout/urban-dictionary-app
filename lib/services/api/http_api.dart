import 'package:http/http.dart' as http;
import 'dart:io';

import 'dart:convert';

import 'package:urban_dict_slang/models/definition.dart';

import 'package:urban_dict_slang/models/term.dart';
import 'package:urban_dict_slang/services/api/api.dart';

class HttpApi implements Api {
  static const String URL_PATH =
      'http://api.urbandictionary.com/v0/define?term=';

  @override
  Future<Term> getDefinitions(String term) async {
    String message;

    try {
      // Check if there is internet connection through looking up example.com domain
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Call to urban dictionary API and mapping to model
        http.Response response = await http.get(URL_PATH + term);
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          List<Definition> definitions = List<Definition>();
          List<dynamic> definitionsList = body['list'];

          if (definitionsList.length == 0) {
            message = 'No such term found, please provide a real word';
          } else {
            for (Map<String, dynamic> json in definitionsList) {
              definitions.add(Definition.fromJson(json));
            }
            message = null;
          }

          Term termModel =
              Term(term, definitions, message, DateTime.now(), false);
          return termModel;
        }
      }
    } on SocketException catch (_) {
      // No internet connection, send user the message
      message = 'No internet connection, please try again';
      return Term(term, null, message, null, false);
    }
  }
}
