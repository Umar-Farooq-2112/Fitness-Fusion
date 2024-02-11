import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/TrainerScreen/TrainerHomeScreen.dart';
import 'package:fitness_fusion/screens/UserScreen/ExerciseScreen.dart';
import 'package:fitness_fusion/screens/UserScreen/NutritionScreen.dart';
import 'package:fitness_fusion/screens/UserScreen/ProfileScreenBody.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TrainerWindow extends StatefulWidget {
  const TrainerWindow({Key? key}) : super(key: key);

  @override
  TrainerWindowState createState() => TrainerWindowState();
}

class TrainerWindowState extends State<TrainerWindow> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TrainerHomeScreen(),
          exerciseScreenBody(),
          nutritionScreenBody(All_Food_Items),
          profileScreenBody(),
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
            backgroundColor: Color.fromARGB(255, 19, 24, 38),
            icon: FaIcon(FontAwesomeIcons.dumbbell),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 19, 24, 38),
            icon: FaIcon(FontAwesomeIcons.utensils),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 19, 24, 38),
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}