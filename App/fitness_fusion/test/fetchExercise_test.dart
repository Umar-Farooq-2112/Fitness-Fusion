// test/math_utils_test.dart
import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

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

void main() {
  group('fetchExercises', () {

    test('ExercisesFirstEntry', () async {
    await fetchAndSetExercises();
      expect(All_Exercises[0][0].name, "Bench press");
      expect(All_Exercises[0][0].id, 1);
      expect(All_Exercises[0][0].push, true);
    });

    test('ALLExercisesLength', () async {
    await fetchAndSetExercises();
      expect(All_Exercises.length, 6);
    });
  
  });
}
