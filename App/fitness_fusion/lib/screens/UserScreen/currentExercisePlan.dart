import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'singleDayExercisePlan.dart';

Widget currentExercisePlan(BuildContext context, WorkoutPlan workoutPlan) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    appBar: buildAppBar(screenHeight, screenWidth),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xfff173e8),
            Color(0xff17e8e8),
          ],
        ),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              tileColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Center(
                child: Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
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
