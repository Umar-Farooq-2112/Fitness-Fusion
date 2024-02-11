import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/TrainerScreen/MadeExerciseDietPlans.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';


class DisplayMadePlansList extends StatefulWidget {
  final double screenWidth;

  DisplayMadePlansList({required this.screenWidth});

  @override
  State<DisplayMadePlansList> createState() => _DisplayMadePlansListState();
}

class _DisplayMadePlansListState extends State<DisplayMadePlansList> {
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
                  '${trainerPlans[index].dateCreated.day} - ${trainerPlans[index].dateCreated.month} - ${trainerPlans[index].dateCreated.year}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  '${trainerPlans[index].dateCreated.hour}:${trainerPlans[index].dateCreated.minute}:${trainerPlans[index].dateCreated.second}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  MadeExerciseDietPlans(trainerPlans[index].trainerWorkoutPlan,
                      trainerPlans[index].trainerDietPlan);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MadeExerciseDietPlans(
                          trainerPlans[index].trainerWorkoutPlan,
                          trainerPlans[index].trainerDietPlan),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 4, thickness: 2);
          },
          itemCount: trainerPlans.length,
        ),
      ),
    );
  }
}
