import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';

Widget buildWelcomeBlock(double screenWidth) {
  return Column(
    children: [
      SizedBox.square(
        dimension: 20.0,
      ),
      Container(
        color: ThemeColors.primary,
        width: screenWidth,
        height: screenWidth * 0.1,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          //color: Color.fromARGB(255, 82, 99, 140),
          elevation: 15,
          shadowColor: ThemeColors.primary,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: ThemeColors.primary,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: ThemeColors.homescreenfont,
                width: 2
              )
            ),
            child: Center(
              child: Text(
                'Welcome ${MyUser.name}',
                style: TextStyle(
                  color: ThemeColors.homescreenfont,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
