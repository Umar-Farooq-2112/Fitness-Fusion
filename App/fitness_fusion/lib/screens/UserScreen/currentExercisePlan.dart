import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'singleDayExercisePlan.dart';

Widget currentExercisePlan(BuildContext context, WorkoutPlan workoutPlan) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: ThemeColors.primary,
    appBar: buildAppBar(screenHeight, screenWidth),
    body: Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors.homescreenfont,
                width: 3
              )
            ),
            child: Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                tileColor: ThemeColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Center(
                  child: Text(
                    'Day ${index + 1}',
                    style: TextStyle(
                      color: ThemeColors.homescreenfont,
                    ),
                  ),
                ),
                onTap: () {
                  singleDayExercisePlan(
                      workoutPlan.Exercise[index], screenHeight, screenWidth);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => singleDayExercisePlan(
                            workoutPlan.Exercise[index], screenHeight, screenWidth)),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 4, thickness: 0);
        },
        itemCount: workoutPlan.Exercise.length,
      ),
    ),
  );
}
