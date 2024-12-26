import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:http/http.dart' as http;

Future<int> checkValidPassword(String username, String password) async {
  // ignore: unused_local_variable
  final response =
      await http.get(Uri.parse(DB.url + "authenticate/$username/$password"));

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData['user_id'];
  }
  return 0;
}


Future<User> fetchUserData(int id) async {
  final response = await http.get(Uri.parse(DB('userdata/$id').getLink()));
  late User temp;

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    temp = new User(
        responseData['user_id'],
        responseData['username'],
        responseData['password'],
        responseData['name'],
        responseData['gender'],
        responseData['weight'].toDouble(),
        responseData['height'].toDouble(),
        responseData['dateOfBirth'],
        responseData['type'],
        responseData['email'],
        responseData['contact']);
  } else {
    print("error Connecting to server");
  }
  return temp;
}
