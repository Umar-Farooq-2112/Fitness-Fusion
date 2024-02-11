import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';

Widget buildWelcomeBlock(double screenWidth) {
  return Column(
    children: [
      SizedBox.square(
        dimension: 20.0,
      ),
      Container(
        width: screenWidth,
        height: screenWidth * 0.1,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          //color: Color.fromARGB(255, 82, 99, 140),
          elevation: 15,
          shadowColor: Color.fromARGB(255, 82, 99, 140),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                colors: [
                  Color(0xfff173e8),
                  Color(0xff17e8e8),
                  Color(0xfff173e8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Text(
                'Welcome ${MyUser.name}',
                style: TextStyle(
                  color: Colors.white,
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
