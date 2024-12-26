import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> retrieveKeywords() async {
  final response = await http.get(Uri.parse(DB('keyword').getLink()));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    if (responseData.isNotEmpty) {
      All_Keywords = responseData
          .map((item) => Keyword(item['id'], item['name']))
          .toList();
    } else {
      print('No Keyword Found');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

Future<void> addKeyword(BuildContext context, String input) async {
  final response = await http.post(Uri.parse(DB('keyword/$input').getLink()));

  if (response.statusCode == 200) {
    createDialog(context, "Keyword added");
  } else {
    createDialog(context, "Unable to add keyword");
  }
}
