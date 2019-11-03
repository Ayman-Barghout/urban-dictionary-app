import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:urban_dict_slang/services/api/api.dart';
import 'package:urban_dict_slang/services/db/database.dart';

class HttpApi implements Api {
  static const String URL_PATH =
      'http://api.urbandictionary.com/v0/define?term=';

  Future<bool> _isUserConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<List<Definition>> getDefinitions(String term) async {
    bool connected = await _isUserConnected();
    print('conntected ' + connected.toString());
    if (connected) {
      http.Response response = await http.get(URL_PATH + term);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Definition> definitions = List<Definition>();
        List<dynamic> definitionsList = body['list'];

        if (definitionsList.length == 0) {
          return [];
        } else {
          for (Map<String, dynamic> json in definitionsList) {
            definitions.add(Definition.fromJson(json));
          }
        }
        return definitions;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
