import 'dart:convert';
import 'package:fitness_fusion/database/database.dart';
import 'package:http/http.dart' as http;


Future<bool> validateUserPlan(int userId) async {
  final url = DB('registered/plan/$userId').getLink(); // Replace with your API endpoint

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['exists'] == 1; // Returns true or false
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    return false; // Return false if there's an error or the API call fails
  }
}

Future<void> findMatchingWorkoutPlan(List<int> keywordIds,int user_id) async {
  // Base URL of your API
  String apiUrl = DB('workout/match/${user_id}').getLink();

  // Create the request body
  Map<String, dynamic> requestBody = {
    'ids': keywordIds,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['Status'] == 'OK') {
        print('Best matching workout plan found: ${responseData['Message']}');
        print('Data: ${responseData['Data']}');
      } else {
        print('API Error: ${responseData['Message']}');
      }
    } else {
      print('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}


Future<void> findMatchingDietPlan(List<int> keywordIds,int user_id) async {
  // Base URL of your API
  String apiUrl = DB('diet/match/${user_id}').getLink();

  // Create the request body
  Map<String, dynamic> requestBody = {
    'ids': keywordIds,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['Status'] == 'OK') {
        print('Best matching diet plan found: ${responseData['Message']}');
        print('Data: ${responseData['Data']}');
      } else {
        print('API Error: ${responseData['Message']}');
      }
    } else {
      print('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}

