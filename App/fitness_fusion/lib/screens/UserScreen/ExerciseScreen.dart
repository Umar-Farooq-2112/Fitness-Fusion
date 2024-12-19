import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'bodyPartWiseExerciseFunctions.dart';

class exerciseScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: ThemeColors.primary,
        appBar: AppBar(
          backgroundColor: ThemeColors.primary,
          title: Center(
            child: Text(
              'Exercises',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ThemeColors.font1,
                letterSpacing: 1.0,
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: ThemeColors.exerciseScreenFont,
            unselectedLabelColor: ThemeColors.exerciseScreenFont2,
            tabs: [
              Tab(
                text: 'Chest',
              ),
              Tab(
                text: 'Back',
              ),
              Tab(
                text: 'Shoulder',
              ),
              Tab(
                text: 'Arm',
              ),
              Tab(
                text: 'Abs',
              ),
              Tab(
                text: 'Legs',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: ChestExercises(All_Exercises[0]),
            ),
            Center(
              child: BackExercises(All_Exercises[1]),
            ),
            Center(
              child: ShoulderExercises(All_Exercises[2]),
            ),
            Center(
              child: ArmExercises(All_Exercises[3]),
            ),
            Center(
              child: AbsExercises(All_Exercises[4]),
            ),
            Center(
              child: LegsExercises(All_Exercises[5]),
            ),
          ],
        ),
      ),
    );
  }
}
