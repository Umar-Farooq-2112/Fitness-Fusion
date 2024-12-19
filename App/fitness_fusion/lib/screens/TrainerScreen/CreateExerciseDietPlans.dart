import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
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
      _CreateExerciseDietPlansState(selectedValue,KeywordsList);
}

class _CreateExerciseDietPlansState extends State<CreateExerciseDietPlans> {
  String selectedValue = '';
  List<Keyword> KeywordsList;
  _CreateExerciseDietPlansState(this.selectedValue,this.KeywordsList);

  @override
  Widget build(BuildContext context) {
    
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: buildAppBar(screenHeight, screenWidth),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ThemeColors.primary,
          appBar: AppBar(
            backgroundColor: ThemeColors.primary,
            bottom: TabBar(
              
              labelColor: ThemeColors.homescreenfont,
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
                child: createWorkoutDayWisePlan(context, selectedValue,KeywordsList)
                ),
              Center(
                child: TrainerDietPlan(KeywordsList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
