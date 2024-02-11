import 'package:fitness_fusion/database/database.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> changePasswordDB(
    BuildContext context, User temp, String pass) async {
  // final response = await http.put(Uri.parse(DB("passsord/${temp.user_id}/$pass").getLink()));
  final response = await http.put(Uri.parse(DB("password/${temp.user_id}/$pass").getLink()));

  if (response.statusCode == 200) {
    Navigator.of(context).pop();
    createDialog(context, "Password Changed");
  } else {
    createDialog(context, "Unable to change Password");
  }
}

Future<void> uploadFeedbackDB(
    BuildContext context,User temp, String description) async {
  final response = await http.post(Uri.parse(DB("feedback/${temp.user_id}/${description}").getLink()));

  if (response.statusCode == 200) {
    Navigator.of(context).pop();
    createDialog(context, "Feedback Uploaded");
  } else {
    createDialog(context, "Unable to upload Feedback");
  }
}

Future<void> changeNameDB(BuildContext context,User temp ,String name)async {

    final response = await http.put(Uri.parse(DB("userdata/name/${temp.user_id}/${name}").getLink()));

    if (response.statusCode == 200) {
    Navigator.of(context).pop();
    createDialog(context, "Name change");
  } else {
    createDialog(context, "unable to change Name");
  }
}

Future<void> changeHeightWeightDB(BuildContext context,User temp ,double weight,double height)async {

    final response = await http.put(Uri.parse(DB("userdata/${temp.user_id}/${weight}/${height}").getLink()));

    if (response.statusCode == 200) {
    Navigator.of(context).pop();
    createDialog(context, "Data Updated");
  } else {
    createDialog(context, "Unable to Save data");
  }
}

