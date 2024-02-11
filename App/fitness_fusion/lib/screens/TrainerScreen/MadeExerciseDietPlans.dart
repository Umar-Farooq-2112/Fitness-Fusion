import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'trainerCurrentDietPlan.dart';
import 'trainerCurrentExercisePlan.dart';

class MadeExerciseDietPlans extends StatelessWidget{
  final WorkoutPlan workoutPlan;
  final DietPlan dietPlan;
  MadeExerciseDietPlans(this.workoutPlan, this.dietPlan);
  @override
  Widget build(BuildContext context, ) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Workout Plan',
                  ),
                  Tab(
                    text: 'Diet Plan',
                  ),
            ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: trainerCurrentExercisePlan(context,workoutPlan),
                ),
                Center(
                  child: trainerCurrentDietPlan(context, dietPlan),
                ),
              ],
            ),
          ),
        ),
    );
  }
}