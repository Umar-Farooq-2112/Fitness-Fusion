import 'package:fitness_fusion/database/assignPlans.dart';
import 'package:fitness_fusion/database/retrieveDietPlan.dart';
import 'package:fitness_fusion/database/retrieveWorkoutPlan.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/screens/UserScreen/usermode.dart';
import 'package:flutter/material.dart';

class KeywordSelectionPage extends StatefulWidget {
  @override
  _KeywordSelectionPageState createState() => _KeywordSelectionPageState();
}

class _KeywordSelectionPageState extends State<KeywordSelectionPage> {
  // To store selected keyword IDs
  List<int> selectedKeywordIds = [];

  Future<void> onSubmit() async {
    await findMatchingWorkoutPlan(selectedKeywordIds, MyUser.user_id);
    await findMatchingDietPlan(selectedKeywordIds, MyUser.user_id);
    print("Assigned a workout plan Successfully");
    MyDietPlan = await retrieveDietPlan(MyUser.user_id);
    MyWorkoutPlan = await retriveWorkoutPlan(MyUser.user_id);
    print("Fetched Successfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: AppBar(
        title: Text('Select Keywords'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: All_Keywords.length,
              itemBuilder: (context, index) {
                final keyword = All_Keywords[index];
                return ListTile(
                  title: Text(
                    keyword.keyword,
                    style: TextStyle(color: ThemeColors.homescreenfont),
                  ),
                  trailing: Checkbox(
                    value: selectedKeywordIds.contains(keyword.id),
                    onChanged: (bool? isChecked) {
                      setState(() {
                        if (isChecked == true) {
                          selectedKeywordIds.add(keyword.id);
                        } else {
                          selectedKeywordIds.remove(keyword.id);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onSubmit,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
