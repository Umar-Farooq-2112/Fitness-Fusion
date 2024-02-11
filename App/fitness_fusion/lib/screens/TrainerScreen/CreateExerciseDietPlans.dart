import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/screens/TrainerScreen/createWorkoutDayWisePlan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'TrainerDietPlan.dart';


class CreateExerciseDietPlans extends StatefulWidget {
  final String selectedValue;
  final String name;
  final List<Keyword> KeywordsList;
  
  CreateExerciseDietPlans(this.selectedValue,this.KeywordsList,this.name);

  @override
  _CreateExerciseDietPlansState createState() =>
      _CreateExerciseDietPlansState(selectedValue);
}

class _CreateExerciseDietPlansState extends State<CreateExerciseDietPlans> {
  String selectedValue = '';
  _CreateExerciseDietPlansState(this.selectedValue);

  @override
  Widget build(BuildContext context) {
    
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Colors.black,
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
                child: createWorkoutDayWisePlan(context, selectedValue)
                ),
              Center(
                child: TrainerDietPlan(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
