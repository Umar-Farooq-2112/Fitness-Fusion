import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/TrainerScreen/trainerCurrentExercisePlan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
class DisplayMadeWorkoutPlansList extends StatefulWidget {
  final double screenWidth;

  DisplayMadeWorkoutPlansList({required this.screenWidth});

  @override
  State<DisplayMadeWorkoutPlansList> createState() => _DisplayMadeWorkoutPlansListState();
}

class _DisplayMadeWorkoutPlansListState extends State<DisplayMadeWorkoutPlansList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(screenHeight, widget.screenWidth),
      body: Container(
        height: double.infinity,
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
                leading: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
                title: Text(
                  '${AllWorkoutPlans[index].enrollmentDate.day} - ${AllWorkoutPlans[index].enrollmentDate.month} - ${AllWorkoutPlans[index].enrollmentDate.year}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  '${AllWorkoutPlans[index].enrollmentDate.hour}:${AllWorkoutPlans[index].enrollmentDate.minute}:${AllWorkoutPlans[index].enrollmentDate.second}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  trainerCurrentExercisePlan(context, AllWorkoutPlans[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => trainerCurrentExercisePlan(context, AllWorkoutPlans[index]),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 4, thickness: 0);
          },
          itemCount: AllWorkoutPlans.length,
          // trainerPlans.length,
        ),
      ),
    );
  }
}
