import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<int> storeWorkoutPlan(BuildContext context, WorkoutPlan input) async {
  Map<String, dynamic> tempBody = {
    "user_id": MyUser.user_id,
    "name": input.name,
    "dateOfCreation": getStringDate(input.enrollmentDate),
  };

  try {
    final response = await http.post(
      Uri.parse(DB("workout").getLink()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(tempBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData.length > 0) {
        MyWorkoutPlan.id = (responseData['id']);
      }
    } else {
      createDialog(context, "Unable to save workout plan");
      return -1;
    }
    int n = input.days;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < input.Exercise[i].length; j++) {
        
        final response2 = await http.post(Uri.parse(
            DB('workout/data/${input.id}/${input.Exercise[i][j].Exercise.id}/${input.Exercise[i][j].Sets}/${i}')
                .getLink()));

        if (response2.statusCode == 200) {
          createDialog(context, "Saved");
        } else {
          createDialog(context, "Error occured $i");
        }
      }
    }
  } catch (e) {
    createDialog(context, "Error: $e");
    return -1;
  }
  return MyWorkoutPlan.id;
}

