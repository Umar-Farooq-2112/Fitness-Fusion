import 'package:flutter/widgets.dart';

class FoodItem {
  late int id;
  late String name;
  late String description;
  late Image image;
  late double calories;
  late double fats;
  late double protein;
  late double carbohydrates;
  late double fibre;
  late double sugar;

  FoodItem(
      int id,
      String name,
      String description,
      Image image,
      double calories,
      double fats,
      double protein,
      double carbohydrates,
      double fibre,
      double sugar) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.calories = calories;
    this.fats = fats;
    this.protein = protein;
    this.carbohydrates = carbohydrates;
    this.fibre = fibre;
    this.sugar = sugar;
  }
}
