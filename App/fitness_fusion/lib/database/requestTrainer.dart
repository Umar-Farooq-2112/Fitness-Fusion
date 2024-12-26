import 'dart:convert';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/User.dart';

Future<bool> requestTrainer(User input) async {
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

Future<bool> manageRequest(int user_id, int res) async {

  final response = await http.post(Uri.parse(DB('request/id/$user_id/$res').getLink()));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<void> fetchRequests() async {
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
      }
    } else {
      print('Error connecting to server. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching requests: $error');
  }
}

