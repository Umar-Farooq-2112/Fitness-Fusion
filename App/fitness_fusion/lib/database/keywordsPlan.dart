import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';

Future<void> insertWorkoutKeywords(List<Keyword> keywords, int w_id) async {
  if (keywords.isEmpty) {
    print('The keywords list is empty. Nothing to send.');
    return;
  }
  List<int> idList = keywords.map((keyword) => keyword.id).toList();
  Map<String, dynamic> jsonData = {'ids': idList};
  String jsonString = jsonEncode(jsonData);
  print(jsonString);
  print(jsonData);
  String url = DB("workout/keywords/$w_id").getLink();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Keywords successfully added: ${response.body}');
    } else {
      print('Failed to add keywords. Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (error) {
    print("CHeck 6");
    print('An error occurred: $error');
  }
}

Future<void> insertDietKeywords(List<Keyword> keywords, int w_id) async {
  List<int> idList = keywords.map((keyword) => keyword.id).toList();
  Map<String, dynamic> jsonData = {'ids': idList};
  String jsonString = jsonEncode(jsonData);

  String url = DB("diet/keywords/$w_id").getLink();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Keywords successfully added: ${response.body}');
    } else {
      print('Failed to add keywords. Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (error) {
    print('An error occurred: $error');
  }
}
