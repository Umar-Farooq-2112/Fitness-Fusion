import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';


class SingleExerciseItemScreen extends StatelessWidget {
  final Exercises item;

  SingleExerciseItemScreen(this.item);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff173e8),
              Color(0xff17e8e8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Container(
                  child: item.image,
                  height: screenHeight * 0.3,
                ),
                heightFactor: 1.1),
            ListTile(
              title: Center(
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: screenHeight * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(item.description,
              maxLines: 10,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
