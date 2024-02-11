import 'package:flutter/material.dart';

class Exercises {
  late int id;
  late String name;
  late String description;
  late Image image;
  late String bodyPart;
  late String bodyDomain;
  late bool push;
  late String equipment;

  Exercises(
      int id,
      String name,
      String description,
      Image image,
      String bodyPart,
      String bodyDomain,
      bool push,
      String equipment) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.bodyPart = bodyPart;
    this.bodyDomain = bodyDomain;
    this.push = push;
    this.equipment = equipment;
  }
}
