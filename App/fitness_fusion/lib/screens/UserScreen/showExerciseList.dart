import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'SingleExerciseItemScreen.dart';

Widget ShowExerciseList(List<Exercises> exercises) {
  return Container(

    color: ThemeColors.primary,
    height: double.infinity,
    child: ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          elevation: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          child: ListTile(
            tileColor: ThemeColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              exercises[index].name,
              style: TextStyle(
                color: ThemeColors.exerciseScreenFont,
              ),
            ),
            trailing: exercises[index].image,
            onTap: () {
              SingleExerciseItemScreen(exercises[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleExerciseItemScreen(exercises[index]),
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 4, thickness: 0);
      },
      itemCount: exercises.length,
    ),
  );
}
