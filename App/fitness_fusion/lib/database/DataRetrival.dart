import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchAndSetFoodItems() async {
  final response = await http.get(Uri.parse(DB('fooditems').getLink()));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    if (responseData.length > 0) {
      All_Food_Items = responseData
          .map((item) => FoodItem(
                item['id'],
                item['name'],
                item['description'],
                Image.memory(base64Decode(item['image'])),
                item['calories'].toDouble(),
                item['fats'].toDouble(),
                item['protein'].toDouble(),
                item['carbohydrates'].toDouble(),
                item['fibre'].toDouble(),
                item['sugar'].toDouble(),
              ))
          .toList();
    }
  }
}

List<String> allBodyDomains = [
  'Chest',
  'Back',
  'Shoulder',
  'Arms',
  'Abs',
  'Legs',
];

Future<void> fetchAndSetExercises() async {
  for (int i = 0; i < 6; i++) {
    final response = await http
        .get(Uri.parse(DB('exercises/domain/${allBodyDomains[i]}').getLink()));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      if (responseData.length > 0) {
        All_Exercises[i] = responseData
            .map((item) => Exercises(
                item['id'],
                item['name'],
                item['description'],
                Image.memory(base64Decode(item['image'])),
                item['bodyPart'],
                item['bodyDomain'],
                item['push'] == 1,
                item['equipment']))
            .toList();
      }
    }
  }
}
