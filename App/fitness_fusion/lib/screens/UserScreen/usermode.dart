import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'buildAppBar.dart';
import 'HomeScreenBody.dart';
import 'ExerciseScreen.dart';
import 'NutritionScreen.dart';
import 'ProfileScreenBody.dart';


// **********************     HOME SCREEN     **********************************
class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
          Center(child: homeScreenBody()),
          Center(child: exerciseScreenBody()),
          Center(child: nutritionScreenBody(All_Food_Items)),
          Center(child: profileScreenBody()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
