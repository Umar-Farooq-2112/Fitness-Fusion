import 'package:fitness_fusion/database/WorkoutRetrieval.dart';
import 'package:fitness_fusion/database/keywordsPlan.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/screens/TrainerScreen/WorkoutAddItemsDaysWise.dart';
import 'package:flutter/material.dart';

Widget createWorkoutDayWisePlan(
    BuildContext context, String noOfDays, List<Keyword> KeywordsList) {
  return Scaffold(
    backgroundColor: ThemeColors.primary,
    appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    BorderSide(
                        color: ThemeColors.homescreenfont,
                        width: 2), // Border color and width
                  ),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(ThemeColors.primary)),
              onPressed: () async {
                int w_id = await storeWorkoutPlan(context, MyWorkoutPlan);
                if (w_id != -1) {
                  await insertWorkoutKeywords(KeywordsList, w_id);
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: ThemeColors.homescreenfont,
                ),
              ),
            ),
          ],
        )),
    body: Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.yellow, width: 2), // Yellow border
              borderRadius: BorderRadius.circular(8), // Match card's shape
            ),
            child: Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor: ThemeColors.primary,
                title: Center(
                  child: Text(
                    'Day ${index + 1}',
                    style: TextStyle(
                        color: ThemeColors.homescreenfont,
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
