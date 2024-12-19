import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'CreatePlans.dart';

Widget buildCreatePlansBlock(double screenWidth, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Center(
      child: Container(
        color: ThemeColors.primary,
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              // flex:1,
              child: InkWell(
                onTap: () {
                  // CreatePlans();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreatePlans()),
                  );
                },
                child: Container(
                  height: double.maxFinite,
                  child: Card(
                    color: ThemeColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    elevation: 30,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                      color: ThemeColors.homescreenfont,
                      width: 3
                          
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Create New Plan',
                          style: TextStyle(
                            color: ThemeColors.homescreenfont,
                            fontSize: 20,
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
          ],
        ),
      ),
    ),
  );
}
