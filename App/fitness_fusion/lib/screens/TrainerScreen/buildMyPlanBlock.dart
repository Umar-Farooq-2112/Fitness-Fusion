import 'package:flutter/material.dart';
import 'DisplayMadeWorkoutPlansList.dart';
import 'DisplayMadeDietPlansList.dart';

Widget buildMyPlanBlock(double screenWidth, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  DisplayMadeWorkoutPlansList(screenWidth: screenWidth,);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DisplayMadeWorkoutPlansList(screenWidth: screenWidth,)),
                  );
                },
                child: Container(
                  height: double.maxFinite,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Your Designed Workout Plans',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              // flex:1,
              child: InkWell(
                onTap: () {
                  DisplayMadeDietPlansList(screenWidth: screenWidth,);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DisplayMadeDietPlansList(screenWidth: screenWidth,)),
                  );
                },
                child: Container(
                  height: double.maxFinite,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Your Designed Diet Plans',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
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
  );
}
