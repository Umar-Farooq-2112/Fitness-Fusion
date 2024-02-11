import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;


Future<void> addFoodItem(BuildContext context, FoodItem item) async {


  // final temp = Image.memory(base64Encode(item.image));


  Map<String, dynamic> body = {
    "name": item.name,
    "description": item.description,
    "image": item.image,
    "calories": item.calories,
    "fats": item.fats,
    "protein": item.protein,
    "carbohydrates": item.carbohydrates,
    "fibre": item.fibre,
    "sugar": item.sugar,
  };


  final response = await http.post(
    Uri.parse("http://localhost:4000/fooditems"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(body),
  );

  createDialog(context, "dome");

  if (response.statusCode == 200) {
    createDialog(context, 'Status: ${json.decode(response.body)['Status']}');
  } else {
    createDialog(context, 'Failed: ${response.reasonPhrase}');
  }
}


Future<List<int>> imageToByteList(Image t) async {
  // Load the image
  img.Image? image = img.decodeImage(t as Uint8List);

  // Convert the image to byte list
  List<int> byteList = img.encodePng(image!);

  return byteList;
}