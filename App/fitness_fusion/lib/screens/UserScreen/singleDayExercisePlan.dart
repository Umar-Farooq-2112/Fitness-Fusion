import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'SingleExerciseItemScreen.dart';

Widget singleDayExercisePlan(
    List<WorkoutExercise> exercises, double screenHeight, double screenWidth) {
  return Scaffold(
    backgroundColor: ThemeColors.primary,
    appBar: buildAppBar(screenHeight, screenWidth),
    body: Container(

      height: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.homescreenfont,
              width: 2)
            ),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor: ThemeColors.primary,
                leading: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: ThemeColors.homescreenfont,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      exercises[index].Exercise.name,
                      style: TextStyle(
                        color: ThemeColors.homescreenfont,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Sets:  ',
                          style: TextStyle(
                            color: ThemeColors.homescreenfont,
                          ),
                        ),
                        Text(
                          exercises[index].Sets.toString(),
                          style: TextStyle(
                            color: ThemeColors.homescreenfont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: exercises[index].Exercise.image,
                onTap: () {
                  SingleExerciseItemScreen(exercises[index].Exercise);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SingleExerciseItemScreen(exercises[index].Exercise),
                    ),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 4, thickness: 2);
        },
        itemCount: exercises.length,
      ),
    ),
  );
}
