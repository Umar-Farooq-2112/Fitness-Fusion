import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/screens/Adminscreen/Approval.dart';
import 'package:fitness_fusion/screens/Adminscreen/addKeyword.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

AppBar buildAppBar(double screenHeight, double screenWidth) {
  return AppBar(
      backgroundColor: ThemeColors.primary,
      toolbarHeight: screenHeight * 0.1,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
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
                        color: ThemeColors.homescreenfont,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.035),
          child: Text(
            'Elevate Your Fitness, Elevate Your Life',
            style: TextStyle(
              color: ThemeColors.homescreenfont,
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
    color: ThemeColors.primary,
    child: TableCalendar(
  firstDay: DateTime.utc(2020, 1, 1),
  lastDay: DateTime.utc(2026, 12, 31),
  focusedDay: DateTime.now(),
  formatAnimationCurve: Curves.easeInCirc,
  calendarFormat: CalendarFormat.week,
  headerStyle: HeaderStyle(
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle: TextStyle(color: ThemeColors.homescreenfont,fontWeight: FontWeight.bold), // Change header font color
  ),
  startingDayOfWeek: StartingDayOfWeek.monday,
  onDaySelected: (selectedDay, focusedDay) {
    print("SELECTED DAY: $selectedDay");
  },

  calendarStyle: CalendarStyle(
    todayTextStyle: TextStyle(color: ThemeColors.homescreenfont), // Change today's date text color
    selectedTextStyle: TextStyle(color: ThemeColors.homescreenfont2), // Change selected date text color
    defaultTextStyle: TextStyle(color: ThemeColors.homescreenfont), // Change default day text color
  ),
  
  daysOfWeekStyle: DaysOfWeekStyle(
    weekdayStyle: TextStyle(color: ThemeColors.homescreenfont2), // Change weekday text color
    weekendStyle: TextStyle(color: ThemeColors.homescreenfont2), // Change weekend text color
  ),
)

  );
}

Widget buildCurrentPlansBlock2(double screenWidth, BuildContext context) {
  return Container(
    color: ThemeColors.primary,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ThemeColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25),

                      border: Border.all(
                          color: ThemeColors.homescreenfont, width: 3)),
                  child: InkWell(
                    onTap: () {
                      addKeywords(context);
                    },
                    child: SizedBox(
                      height: double.maxFinite,
                      child: Card(
                        color: ThemeColors.primary,
                        elevation: 10,
                        child: Center(
                            child: Text(
                          'Keyword',
                          style: TextStyle(
                              color: ThemeColors.homescreenfont, fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners

                      border: Border.all(
                          color: ThemeColors.homescreenfont, width: 3)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApprovalList(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: double.maxFinite,
                      child: Card(
                        color: ThemeColors.primary,
                        elevation: 10,
                        child: Center(
                            child: Text(
                          'Trainer',
                          style: TextStyle(
                              color: ThemeColors.homescreenfont, fontSize: 20),
                        )),
                      ),
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
