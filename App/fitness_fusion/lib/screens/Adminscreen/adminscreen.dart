// import 'dart:html';

import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/screens/Adminscreen/manageFeedbacks.dart';
import 'package:fitness_fusion/screens/UserScreen/ExerciseScreen.dart';
import 'package:fitness_fusion/screens/UserScreen/NutritionScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "mywidgets.dart";


class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<Admin> {
  late List<Exercises>? adminExercise;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: buildAppBar(screenHeight, screenWidth),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Center(child: homeScreenBody(context, screenWidth)),
          Center(child: exerciseScreenBody()),
          Center(child: nutritionScreenBody(All_Food_Items)),
          Center(child: profileScreenBody(context, screenWidth)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 19, 24, 38),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dumbbell),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.utensils),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

Widget homeScreenBody(BuildContext context, double screenWidth) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: buildCalendarBlock(),
        ),
      ),
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildCurrentPlansBlock2(screenWidth, context),
        ),
      ),
    ],
  );
}


Widget profileScreenBody(BuildContext context, double screenWidth) {
  return Container(
    child: Center(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.primary,
              side: BorderSide(
                color: ThemeColors.homescreenfont,
                width: 4
              )
            ),
            child: Text("View FeedBacks",style: TextStyle(color: ThemeColors.homescreenfont),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackList(),
                ),
              );
            },
          )),
    ),
  );
}
