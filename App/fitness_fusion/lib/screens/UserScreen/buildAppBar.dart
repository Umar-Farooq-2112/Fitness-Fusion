import 'package:flutter/material.dart';

AppBar buildAppBar(double screenHeight, double screenWidth) {
  return AppBar(

    toolbarHeight: screenHeight * 0.035,
    title: Text(
      'Fitness Fusion',
      style: TextStyle(
        color: Colors.white,
        letterSpacing: 2.0,
      ),
    ),
    backgroundColor: Colors.black,
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.035),
      child: Text(
        'Elevate Your Fitness, Elevate Your Life',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    ),
  );
}
