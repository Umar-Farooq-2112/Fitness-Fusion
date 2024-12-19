import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'SingleFoodItemScreen.dart';

Widget nutritionScreenBody(List<FoodItem> items) {
  return Scaffold(
    backgroundColor: ThemeColors.primary,
      appBar: AppBar(
        backgroundColor:  ThemeColors.primary,
        title: Center(
          child: Text(
            'Food Items',
            style: TextStyle(
              color:  ThemeColors.exerciseScreenFont,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor:  ThemeColors.primary,
                title: Text(
                  items[index].name,
                  style: TextStyle(
                    color:  ThemeColors.exerciseScreenFont,
                  ),
                ),
                trailing: items[index].image,
                onTap: () {
                  SingleFoodItemScreen(items[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleFoodItemScreen(items[index]),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 4, thickness: 0);
          },
          itemCount: items.length,
        ),
      ));
}
