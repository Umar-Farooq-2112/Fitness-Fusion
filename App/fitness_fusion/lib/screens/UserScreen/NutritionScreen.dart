import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:flutter/material.dart';
import 'SingleFoodItemScreen.dart';

Widget nutritionScreenBody(List<FoodItem> items) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Food Items',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff173e8),
              Color(0xff17e8e8),
            ],
          ),
        ),
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
                tileColor: Colors.black,
                title: Text(
                  items[index].name,
                  style: TextStyle(
                    color: Colors.white,
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
