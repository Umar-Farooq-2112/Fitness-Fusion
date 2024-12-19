import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';


class SingleFoodItemScreen extends StatelessWidget {
  final FoodItem item;

  SingleFoodItemScreen(this.item);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  ThemeColors.primary,
      appBar: buildAppBar(screenHeight, screenWidth),
      body: Container(

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
                    color:  ThemeColors.exerciseScreenFont,
                  ),
                ),
              ),
              subtitle: Text(item.description, maxLines: 10,
                style: TextStyle(
                  color:  ThemeColors.exerciseScreenFont2,
                  fontSize: 15,
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Calories:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:  ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.calories.toString(),
                        style: TextStyle(
                          color:ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Protein:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.protein.toString(),
                        style: TextStyle(
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Carbohydrates:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.carbohydrates.toString(),
                        style: TextStyle(
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Fats:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.fats.toString(),
                        style: TextStyle(
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Fibre:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.fibre.toString(),
                        style: TextStyle(
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Sugar:\t',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                      Text(
                        item.sugar.toString(),
                        style: TextStyle(
                          color: ThemeColors.exerciseScreenFont2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
