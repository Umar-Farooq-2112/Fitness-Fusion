import 'dart:convert';

import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/FeedBack.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:http/http.dart' as http;

Future<void> retrieveFeedback() async {
  try {
    final response = await http.get(Uri.parse(DB('feedback').getLink()));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty) {
        All_Feedbacks = responseData.map((item) =>
            UserFeedback(item['username'], getDateTime(item['date']), item['description'])).toList();
      }
    } 
  } catch (error) {
        print('catch block');
  }
}