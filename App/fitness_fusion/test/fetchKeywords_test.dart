import 'dart:convert';

import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

Future<void> retrieveKeywords() async {
  final response = await http.get(Uri.parse('http://localhost:4000/keyword'));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    if (responseData.isNotEmpty) {
      All_Keywords = responseData
          .map((item) => Keyword(item['id'], item['name']))
          .toList();
    } else {
    }
  } else {
  }
}

void main() {
  group('fetchKeywords', () {

    test('KeywordsFirstEntry', () async {
    await retrieveKeywords();
      expect(All_Keywords[0].keyword, "Fat loss");
      expect(All_Keywords[1].keyword, "Muscle Gain");
    });

    test('KeywordsLength', () async {
    await retrieveKeywords();
      expect(All_Keywords.length, 5);
    });
  
  });
}
