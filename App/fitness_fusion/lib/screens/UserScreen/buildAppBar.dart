import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(double screenHeight, double screenWidth) {
  return AppBar(
    backgroundColor: ThemeColors.primary,
    toolbarHeight: screenHeight * 0.035,
    title: Text(
      'Fitness Fusion',
      style: TextStyle(
        color: ThemeColors.appBarFont,
        letterSpacing: 2.0,
      ),
    ),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.035),
      child: Text(
        'Elevate Your Fitness, Elevate Your Life',
        style: TextStyle(
          color: ThemeColors.appBarFont2,
          fontSize: 13,
        ),
      ),
    ),
  );
}
