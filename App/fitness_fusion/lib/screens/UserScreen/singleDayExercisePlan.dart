import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'SingleExerciseItemScreen.dart';

Widget singleDayExercisePlan(
    List<WorkoutExercise> exercises, double screenHeight, double screenWidth) {
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
      height: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              tileColor: Colors.black,
              leading: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    exercises[index].Exercise.name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Sets:  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        exercises[index].Sets.toString(),
                        style: TextStyle(
                          color: Colors.white,
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
