import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildCreatePlansBlock.dart';
class TrainerHomeScreen extends StatefulWidget {
  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xfff173e8),
        //       Color(0xff17e8e8),
        //     ],
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   flex: 2,
            //   child: Padding(
            //     padding: const EdgeInsets.all(4.0),
            //     child: buildWelcomeBlock(screenWidth),
            //   ),
            // ),
            // Expanded(
            //   flex: 4,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: buildMyPlanBlock(screenWidth, context),
            //   ),
            // ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildCreatePlansBlock(screenWidth, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
