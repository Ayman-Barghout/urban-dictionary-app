import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:urban_dict_slang/core/services/api/api.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';

class HttpApi implements Api {
  static const String baseUrl =
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
  Future<List<Definition>?> getDefinitions(String term) async {
    final bool connected = await _isUserConnected();
    if (connected) {
      final uri = Uri.parse(baseUrl + term);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;

        final List<Definition> definitions = [];
        final List<Map<String, dynamic>> definitionsList =
            List<Map<String, dynamic>>.from(body['list'] as List);

        for (final Map<String, dynamic> json in definitionsList) {
          definitions.add(Definition.fromJson(json));
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
