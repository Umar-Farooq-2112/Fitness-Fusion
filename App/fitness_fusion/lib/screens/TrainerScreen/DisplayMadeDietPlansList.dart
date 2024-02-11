import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/TrainerScreen/trainerCurrentDietPlan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';

class DisplayMadeDietPlansList extends StatefulWidget {
  final double screenWidth;

  DisplayMadeDietPlansList({required this.screenWidth});

  @override
  State<DisplayMadeDietPlansList> createState() => _DisplayMadeDietPlansListState();
}

class _DisplayMadeDietPlansListState extends State<DisplayMadeDietPlansList> {
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
                  '${AllDietPlans[index].enrollmentDate.day} - ${AllDietPlans[index].enrollmentDate.month} - ${AllDietPlans[index].enrollmentDate.year}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  '${AllDietPlans[index].enrollmentDate.hour}:${AllDietPlans[index].enrollmentDate.minute}:${AllDietPlans[index].enrollmentDate.second}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  trainerCurrentDietPlan(context, AllDietPlans[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => trainerCurrentDietPlan(context, AllDietPlans[index]),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 4, thickness: 0);
          },
          itemCount: AllDietPlans.length,
          // trainerPlans.length,
        ),
      ),
    );
  }
}
