import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';
import 'currentExercisePlan.dart';
import 'currentDietPlan.dart';



Widget buildCurrentPlansBlock(double screenWidth, BuildContext context) {
  return Container(
    //color: Color.fromARGB(255, 170, 184, 196),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          //color: Color.fromARGB(255, 170, 184, 196),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                // flex:1,
                child: InkWell(
                  onTap: () {
                    currentExercisePlan(context, MyWorkoutPlan);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              currentExercisePlan(context, MyWorkoutPlan)),
                    );
                  },
                  child: Container(
                    height: double.maxFinite,
                    child: Card(
                      // color: Color.fromARGB(255, 239, 234, 221),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff15e3dc),
                              Color(0xff2987cc),
                              Color(0xff1839de),
                              Color(0xff2987cc),
                              Color(0xff15e3dc),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Your Workout Plan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    currentDietPlan(context, MyDietPlan);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              currentDietPlan(context, MyDietPlan)),
                    );
                  },
                  child: Container(
                    height: double.maxFinite,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff15e3dc),
                              Color(0xff2987cc),
                              Color(0xff1839de),
                              Color(0xff2987cc),
                              Color(0xff15e3dc),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Your Diet Plan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
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
