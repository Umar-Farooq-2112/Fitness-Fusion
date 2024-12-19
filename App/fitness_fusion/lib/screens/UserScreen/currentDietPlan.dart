import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'SingleFoodItemScreen.dart';


Widget currentDietPlan(BuildContext context, DietPlan dietPlan) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: ThemeColors.primary,
    appBar: buildAppBar(screenHeight, screenWidth),
    body: Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors.homescreenfont,
                width: 3
              )
            ),
            child: Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor: ThemeColors.primary,
                leading: Text(
                  dietPlan.Foods[index].time.format(context),
                  style: TextStyle(
                    color: ThemeColors.homescreenfont,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      dietPlan.Foods[index].item.name,
                      style: TextStyle(
                        color: ThemeColors.homescreenfont,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Quantity:  ',
                          style: TextStyle(
                            color: ThemeColors.homescreenfont,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          dietPlan.Foods[index].quantity.toString(),
                          style: TextStyle(
                            color: ThemeColors.homescreenfont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: SizedBox.square(
                  dimension: screenWidth * 0.12,
                  child: dietPlan.Foods[index].item.image,
                ),
                onTap: () {
                  SingleFoodItemScreen(dietPlan.Foods[index].item);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SingleFoodItemScreen(dietPlan.Foods[index].item),
                    ),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 4, thickness: 2);
        },
        itemCount: dietPlan.Foods.length,
      ),
    ),
  );
}
