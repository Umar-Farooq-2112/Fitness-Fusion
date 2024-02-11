import 'dart:convert';

import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';

late String file;
class TestPage extends StatefulWidget {

  
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: Container(
            child: ListView.builder(
            // itemCount: All_Exercises[0].length,
            itemCount: All_Exercises[0].length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.memory(base64Decode(file))
                  
                ]                
              );
            },
          )
      ),
    );
  }
}
