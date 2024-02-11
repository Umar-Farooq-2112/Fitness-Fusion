import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> registerNewUser(
    BuildContext context, User input) async {
  Map<String, dynamic> tempBody = {
    "username": input.username,
    "password": input.password,
    "usertype": input.type,
    "name": input.name,
    "gender": input.gender[0],
    "height": input.height,
    "weight": input.weight,
    "dateOfBirth": input.getdate(),
    "email": input.email,
    "contact": input.contact
  };

  try {
    final response = await http.post(
      Uri.parse(DB("registration").getLink()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(tempBody),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}

Future<int> ifUserPresent(BuildContext context, String username) async {
  try {
    final response =
        await http.get(Uri.parse(DB("validate/$username").getLink()));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData.length > 0) {
        return responseData['user_id'];
      }
    }
  } catch (error) {
    return 0;
  }
  return 0;
}
