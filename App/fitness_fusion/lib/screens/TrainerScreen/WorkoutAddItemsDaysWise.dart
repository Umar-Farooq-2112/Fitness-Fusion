import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/screens/TrainerScreen/displayExercisesAndSetsForPlan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// //*   Workout Plan Testing    *****

// ignore: must_be_immutable
class WorkoutAddItemsDaysWise extends StatefulWidget {
  late int index;
  WorkoutAddItemsDaysWise(int index){
    this.index=index;
  }
  @override
  State<WorkoutAddItemsDaysWise> createState() =>
      _WorkoutAddItemsDaysWiseState(index);
}
class _WorkoutAddItemsDaysWiseState extends State<WorkoutAddItemsDaysWise> {
  late int Index;
  // List<WorkoutExercise> addExercise = [];
  _WorkoutAddItemsDaysWiseState(int index){
    this.Index=index;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(screenHeight, screenWidth),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff173e8),
              Color(0xff17e8e8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        child: Text('Add Exercises',
                        style: TextStyle(color:Colors.white,),),
                        onPressed: () async {
                          final result =
                              await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DisplayExercisesAndSetsForPlan();
                            },
                          ));

                          if (result != null) {
                            Exercises selectedExercise = result['exercise'];
                            int enteredSets = result['sets'];

                            // Add the new exercise to the list
                            MyWorkoutPlan.makePlan(WorkoutExercise(
                              selectedExercise,
                              Index+1,
                              enteredSets
                            ));

                            // Update the UI
                            setState(() {});
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: () async {
                          Fluttertoast.showToast(
                            msg: "Plan Saved!",
                            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                            gravity: ToastGravity.BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                            timeInSecForIosWeb: 1, // the duration in seconds that the toast should be displayed
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: MyWorkoutPlan.Exercise[Index].length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          tileColor: Colors.black,
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${MyWorkoutPlan.Exercise[Index][index].Exercise.name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Sets: ${MyWorkoutPlan.Exercise[Index][index].Sets}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                MyWorkoutPlan.Exercise[Index].removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}