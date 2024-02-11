import 'dart:convert';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:flutter/material.dart';

Future<bool> requestTrainer(BuildContext context, User input) async {
  Map<String, dynamic> tempBody = {
    "username": input.username,
    "password": input.password,
    "name": input.name,
    "gender": input.gender[0],
    "height": input.height,
    "weight": input.weight,
    "date_of_birth": input.getdate(),
    "email": input.email,
    "contact": input.contact,
  };

  try {
    final response = await http.post(
      Uri.parse(DB("request").getLink()),
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

Future<bool> manageRequest(BuildContext context, int user_id, int res) async {

  final response = await http.post(Uri.parse(DB('request/id/$user_id/$res').getLink()));

  if (response.statusCode == 200) {
    return true;
  } else {
    createDialog(context, "Error managing the request");
    return false;
  }
}

Future<void> fetchRequests(BuildContext context) async {
  try {
    final response = await http.get(Uri.parse(DB('request').getLink()));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is List) {
        Requests = responseData
            .map((item) => User(
                item['id'] ?? '',
                item['username'] ?? '',
                "",
                item['name'] ?? '',
                item['gender'] ?? '',
                item['height'] ?? '',
                item['weight'] ?? '',
                item['date_of_birth'] ?? '',
                item['type'] ?? '',
                item['email'] ?? '',
                item['contact'] ?? ''))
            .toList();

      } else {
        print('Invalid response data format: $responseData');
        createDialog(context, 'Error parsing response data');
      }
    } else {
      print('Error connecting to server. Status code: ${response.statusCode}');
      createDialog(context, 'Error connecting to server');
    }
  } catch (error) {
    print('Error fetching requests: $error');
    createDialog(context, 'Error fetching requests');
  }
}

