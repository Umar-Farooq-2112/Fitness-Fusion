import 'dart:async';

import 'package:fitness_fusion/screens/Authentication/loginPage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late BuildContext myContext;

  @override
  Widget build(BuildContext context) {
    myContext = context; // Store the context during build

    return Scaffold(
      body: Container(
        color: Colors.cyanAccent[400],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
              Text(
                " Fitfusion: Train hard, stay consistent, be patient",
                style: TextStyle(
                  fontFamily: 'Welcome',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {

      Navigator.pushReplacement(
        myContext, // Use the stored context
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    super.initState();
  }
}
