import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';

class DisplayExercisesAndSetsForPlan extends StatefulWidget {
  @override
  State<DisplayExercisesAndSetsForPlan> createState() =>
      _DisplayExercisesAndSetsForPlanState();
}

class _DisplayExercisesAndSetsForPlanState
    extends State<DisplayExercisesAndSetsForPlan> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
      body: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Chest',
                ),
                Tab(
                  text: 'Back',
                ),
                Tab(
                  text: 'Shoulder',
                ),
                Tab(
                  text: 'Arm',
                ),
                Tab(
                  text: 'Abs',
                ),
                Tab(
                  text: 'Legs',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: ChooseExercise(All_Exercises[0]),
              ),
              Center(
                child: ChooseExercise(All_Exercises[1]),
              ),
              Center(
                child: ChooseExercise(All_Exercises[2]),
              ),
              Center(
                child: ChooseExercise(All_Exercises[3]),
              ),
              Center(
                child: ChooseExercise(All_Exercises[4]),
              ),
              Center(
                child: ChooseExercise(All_Exercises[5]),
              ),
            ],
          ),
        ),
          ),
    );
  }

  Future<int?> _showInputDialog(BuildContext context,
      {int? initialValue}) async {
    TextEditingController setsController =
        TextEditingController(text: initialValue?.toString() ?? '');

    return showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Number of Sets'),
          content: TextField(
            controller: setsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Sets'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                int enteredSets = int.tryParse(setsController.text) ?? 0;
                if (enteredSets > 0) {
                  Navigator.of(context).pop(enteredSets);
                } else {
                  // Show an error message or handle invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invalid input. Sets must be greater than 0.',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget ChooseExercise(List<Exercises> exercises) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xfff173e8),
            Color(0xff17e8e8),
          ],
        ),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              tileColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text(
                exercises[index].name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: exercises[index].image,
              onTap: () async {
                int? enteredSets = await _showInputDialog(context);
                if (enteredSets != null) {
                  // Use enteredSets as needed
                  Exercises selectedExercise = exercises[index];
                  // Pass the selected exercise and entered sets back to the calling widget
                  Navigator.of(context)
                      .pop({'exercise': selectedExercise, 'sets': enteredSets});
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 4, thickness: 0);
        },
        itemCount: exercises.length,
      ),
    );
  }

}
