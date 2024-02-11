import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<DietPlan> retrieveDietPlan(BuildContext context, int user_id) async {
  DietPlan temp = new DietPlan(0, getDateTime('2003-12-12'), 'temp');

  final response = await http.get(Uri.parse(DB("diet/$user_id").getLink()));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData.length > 0) {
      temp = new DietPlan(responseData['id'],
          getDateTime(responseData['enrollmentDate']), responseData['name']);

      final response2 =
          await http.get(Uri.parse(DB("diet/data/${temp.id}").getLink()));
      if (response2.statusCode == 200) {
        final response2Data = jsonDecode(response2.body);
        if (response2Data.length > 0) {
          temp.Foods = ((response2Data as List<dynamic>))
              .map((item) => Meal(
                    FoodItem(
                        item['id'],
                        item['name'],
                        item['description'],
                        Image.memory(base64Decode(item['image'])),
                        item['calories'],
                        item['fats'],
                        item['protein'],
                        item['carbohydrates'],
                        item['fibre'],
                        item['sugar']),
                    item['quantity'],
                    getTimeofDay(
                      item['time'],
                    ),
                  ))
              .toList();
        }
      }
    }
  }
  return temp;
}

Future<void> storeDietPlan(
  BuildContext context,
  DietPlan input,
) async {
  Map<String, dynamic> tempBody = {
    "user_id": MyUser.user_id,
    "name": input.name,
    "dateOfCreation": getStringDate(input.enrollmentDate),
  };

  try {
    final response = await http.post(
      Uri.parse(DB("diet").getLink()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(tempBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData.length > 0) {
        MyDietPlan.id = (responseData['id']);
      }
    } else {
      createDialog(context, "Unable to save workout plan");
      return;
    }

    int n = input.Foods.length;
    for (int i = 0; i < n; i++) {
      Map<String, dynamic> tempBody2 = {
        "time": getStringTime(input.Foods[i].time),
      };

      final response2 = await http.post(
        Uri.parse(
          DB('meal/${input.Foods[i].item.id}/${input.Foods[i].quantity}/${MyDietPlan.id}')
              .getLink(),
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(tempBody2),
      );

      if (response2.statusCode == 200) {
      } else {
        createDialog(context, "Error occured $i");
        return;
      }
    }
    createDialog(context, "Saved");

  } catch (e) {
    createDialog(context, "Error: $e");
  }
}
