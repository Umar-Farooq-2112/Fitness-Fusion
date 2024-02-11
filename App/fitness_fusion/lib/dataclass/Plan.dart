import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:flutter/material.dart';

class Plan {
  late int id;
  late DateTime enrollmentDate;
  late String name;

  Plan(int id, DateTime enrollmentDate, String name) {
    this.id = id;
    this.name = name;
    this.enrollmentDate = enrollmentDate;
  }

  String getdate() {
    return "${enrollmentDate.year}-${enrollmentDate.month}-${enrollmentDate.day}";
  }
}

class WorkoutPlan extends Plan {
  late List<List<WorkoutExercise>> Exercise;
  late int days;

  WorkoutPlan(int id, DateTime enrollmentDate, String name, int days)
      : super(id, enrollmentDate, name) {
    this.days = days;
    Exercise = List.generate(days, (row) => []);
  }

  void makePlan(WorkoutExercise temp) {
    Exercise[temp.day-1].add(temp);
  }
  void addExercises(List<WorkoutExercise> temp) {
    for (int i = 0; i < temp.length; i++) {
      Exercise[temp[i].day].add(temp[i]);
    }
  }
}

class WorkoutExercise {
  late Exercises Exercise;
  late int Sets;
  late int day;

  WorkoutExercise(Exercises Exercise, int day, int Sets) {
    this.Exercise = Exercise;
    this.Sets = Sets;
    this.day = day;
  }
}

class DietPlan extends Plan {
  late List<Meal> Foods;

  DietPlan(int id, DateTime enrollmentDate, String name)
      : super(id, enrollmentDate, name) {
        this.Foods = [];
  }

}

class Meal {
  late FoodItem item;
  late double quantity;
  late TimeOfDay time;

  Meal(FoodItem item, double quantity, TimeOfDay time) {
    this.item = item;
    this.quantity = quantity;
    this.time = time;
  }
}

class TrainerPlans {
  late DateTime dateCreated;
  late WorkoutPlan trainerWorkoutPlan;
  late DietPlan trainerDietPlan;

  TrainerPlans(DateTime dateCreated, WorkoutPlan trainerWorkoutPlan,
      DietPlan trainerDietPlan) {
    this.dateCreated = dateCreated;
    this.trainerWorkoutPlan = trainerWorkoutPlan;
    this.trainerDietPlan = trainerDietPlan;
  }
}

DateTime getDateTime(String input) {
  int year = int.parse(input.substring(0, 4));
  int month;
  int day;
  String temp = input.substring(5);
  if (int.tryParse(temp[1]) == null) {
    month = int.parse(temp[0]);
    temp = temp.substring(2);
  } else {
    month = int.parse(temp.substring(0, 2).toString());
    temp = temp.substring(3);
  }
  if (temp.length == 1) {
    day = int.parse(temp[0]);
  } else {
    int? tempa = int.tryParse(temp.substring(0, 2));
    day = (tempa == null) ? int.parse(temp[0]) : tempa;
  }
  return DateTime(year, month, day);
}

String getStringDate(DateTime input) {
  String year = input.year.toString();
  String day = (input.day < 10) ? "0${input.day}" : input.day.toString();
  String month =
      (input.month < 10) ? "0${input.month}" : input.month.toString();
  return year + "-" + month + "-" + day;
}

String getStringTime(TimeOfDay input) {
  String hour = (input.hour < 10) ? "0${input.hour}" : input.hour.toString();
  String min = (input.minute < 10) ? "0${input.minute}" : input.minute.toString();
  String sec = '00';

  return hour + ":" + min + ":" + sec;
}

TimeOfDay getTimeofDay(String input){
  int hour = 0;
  if(int.tryParse(input[0]+input[1])==null){
    hour = int.parse(input[0]);
    input = input.substring(2);
  }else {
    hour = int.parse(input[0]+input[1]);
    input = input.substring(3);
  }
  int minute = 0;
  if(int.tryParse(input[0]+input[1])==null){
    minute = int.parse(input[0]);
    input = input.substring(2);
  }else {
    minute = int.parse(input[0]+input[1]);
  }


  return TimeOfDay(hour: hour, minute: minute);
}