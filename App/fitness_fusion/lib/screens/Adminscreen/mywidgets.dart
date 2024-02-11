import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/screens/Adminscreen/addExercise.dart';
import 'package:fitness_fusion/screens/Adminscreen/addFood.dart';
import 'package:fitness_fusion/screens/Adminscreen/addKeyword.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

AppBar buildAppBar(double screenHeight, double screenWidth) {
  return AppBar(
      backgroundColor: const Color.fromARGB(255, 170, 184, 196),
      toolbarHeight: screenHeight * 0.1,
      title: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      'Fitness Fusion : Train hard, stay consistent, be patient',
                      style: TextStyle(
                        fontFamily: 'Welcome',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 14, 10, 10),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/hi.gif"),
                    ))
              ],
            ),
          ],
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.035),
          child: const Text(
            'Elevate Your Fitness, Elevate Your Life',
            style: TextStyle(
              color: Color.fromARGB(255, 170, 184, 196),
              fontSize: 13,
            ),
          )));
}

Widget buildWelcomeBlock() {
  return Container(
    color: const Color.fromARGB(255, 125, 156, 242),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Welcome Admin!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.png'),
        )
      ],
    ),
  );
}

Widget buildCalendarBlock() {
  return Container(
    color: const Color.fromARGB(255, 170, 184, 196),
    child: TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1), // Adjust the start date as needed
      lastDay: DateTime.utc(2026, 12, 31), // Adjust the end date as needed
      focusedDay: DateTime.now(),
      formatAnimationCurve: Curves.easeInCirc,
      calendarFormat: CalendarFormat.week,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: (selectedDay, focusedDay) => {
        print("SELECTED DAY: $selectedDay"),
      },

      // Add more properties and callbacks as needed
    ),
  );
}

Widget buildCurrentPlansBlock(double screenWidth, BuildContext context) {
  late List<FoodItem>? adminfood = [];
  return Container(
    color: const Color.fromARGB(255, 19, 24, 38),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 16, 37, 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExercise(
                          exercises: [],
                        ), ////////////////////////////////
                      ),
                    );
                  },
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 239, 234, 221),
                      elevation: 10,
                      child: Center(child: Text('Exercise')),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddfoodItems(foodItemss: adminfood),
                      ),
                    );
                  },
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 239, 234, 221),
                      elevation: 10,
                      child: Center(child: Text('Diet Item')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildCurrentPlansBlock2(double screenWidth, BuildContext context) {
  return Container(
    color: const Color.fromARGB(255, 19, 24, 38),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 16, 37, 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    addKeywords(context);
                  },
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 239, 234, 221),
                      elevation: 10,
                      child: Center(child: Text('Keyword')),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddTrainer(trainers: const []),
                    //   ),
                    // );
                  },
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 239, 234, 221),
                      elevation: 10,
                      child: Center(child: Text('Trainer')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget ChestExercises() {
  return const Text(
    "CHEST EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget BackExercises() {
  return const Text(
    "BACK EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget BicepExercises() {
  return const Text(
    "BICEP EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget TricepExercises() {
  return const Text(
    "TRICEP EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget ShoulderExercises() {
  return const Text(
    "SHOULDER EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget ForearmExercises() {
  return const Text(
    "FOREARM EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget AbsExercises() {
  return const Text(
    "ABS EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

Widget LegsExercises() {
  return const Text(
    "LEGS EXERCISES",
    style: TextStyle(
      color: Colors.black,
    ),
  );
}

class RoundButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgcolor;
  final TextStyle? style;
  final VoidCallback? callBack;

  const RoundButton(
      {super.key,
      required this.btnName,
      this.icon,
      this.bgcolor = Colors.blueAccent,
      this.style,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callBack!();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          shadowColor: bgcolor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ))),
      child: icon != null
          ? Row(
              children: [
                icon!,
                Text(
                  btnName,
                  style: style,
                )
              ],
            )
          : Text(
              btnName,
              style: style,
            ),
    );
  }
}
