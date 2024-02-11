import 'package:flutter/material.dart';
import 'CreatePlans.dart';

Widget buildCreatePlansBlock(double screenWidth, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Center(
      child: Container(
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
                    // color: Color.fromARGB(255, 239, 234, 221),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 30,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
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
                          'Create New Plan',
                          style: TextStyle(
                            color: Colors.white,
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
