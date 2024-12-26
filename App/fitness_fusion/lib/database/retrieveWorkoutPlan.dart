import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WorkoutPlan> retriveWorkoutPlan(int user_id) async {
  WorkoutPlan temp = new WorkoutPlan(0, getDateTime('2000-01-01'), "temp", 0);
  List<WorkoutExercise> tempexercise = [];

  final response = await http.get(Uri.parse(DB("workout/$user_id").getLink()));
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData.length > 0) {
      temp = new WorkoutPlan(
          responseData['id'],
          getDateTime(responseData['enrollmentDate']),
          responseData['name'],
          responseData['days'] + 1);

      final response2 =
          await http.get(Uri.parse(DB("workout/data/${temp.id}").getLink()));

      if (response2.statusCode == 200) {
        final response2Data = jsonDecode(response2.body);

        if (response2Data.length > 0) {
          tempexercise = (response2Data as List<dynamic>)
              .map((item) => WorkoutExercise(
                    Exercises(
                      item['id'],
                      item['name'],
                      item['description'],
                      Image.memory(base64Decode(item['image'])),
                      item['bodyPart'],
                      item['bodyDomain'],
                      item['push'] == 1,
                      item['equipment'],
                    ),
                    item['day'],
                    item['Sets'],
                  ))
              .toList();

          // createDialog(context, response2Data.length.toString());

          int len = tempexercise.length;
          for (int i = 0; i < len; i++) {
            temp.Exercise[tempexercise[i].day].add(tempexercise[i]);
          }
        }
      }
    }
  }
  return temp;
}
