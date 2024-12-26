// test/math_utils_test.dart
import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

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
    } else {}
  }
}

void main(){
  group('fetchFoodItems', () {
    test('AllFoodItemsFirstEntry', () async {
      await fetchAndSetFoodItems();
      expect(All_Food_Items[0].name, "Broccoli");
      expect(All_Food_Items[0].id, 1);
      expect(All_Food_Items[0].sugar, 0);
    });

    test('AllFoodItemsLength', () async {
      await fetchAndSetFoodItems();
      expect(All_Food_Items.length, equals(9));
    });
  });
}
