import 'package:fitness_fusion/database/WorkoutRetrieval.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/TrainerScreen/WorkoutAddItemsDaysWise.dart';
import 'package:flutter/material.dart';

Widget createWorkoutDayWisePlan(BuildContext context, String noOfDays) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
           style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
          onPressed: () async {
            await storeWorkoutPlan(context,MyWorkoutPlan);
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    )),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              tileColor: Colors.black,
              title: Center(
                child: Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                WorkoutAddItemsDaysWise(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutAddItemsDaysWise(index)),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 4, thickness: 2);
        },
        itemCount: int.parse(noOfDays),
      ),
    ),
  );
}
