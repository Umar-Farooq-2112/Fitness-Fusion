import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'CreateExerciseDietPlans.dart';

class CreatePlans extends StatefulWidget {
  @override
  State<CreatePlans> createState() => _CreatePlansState();
}

class _CreatePlansState extends State<CreatePlans> {
  List<Keyword> selectedBottomDropdownValues = [];
  List<Keyword> addedItems = [];
  late TextEditingController planNameController;

  @override
  void initState() {
    super.initState();
    planNameController = TextEditingController();
  }

  @override
  void dispose() {
    planNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedValue = '1';
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: buildAppBar(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width,
      ),
      body: Container(
        color: ThemeColors.primary,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.width * 1.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              color: ThemeColors.primary,
              margin: EdgeInsets.all(8.0),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      'Name of Plan',
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors.homescreenfont,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            style: TextStyle(
                              color: ThemeColors.homescreenfont
                            ),
                            controller: planNameController,
                            decoration: InputDecoration(
                              labelText: 'Plan Name',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kindly Select No of Days',
                            style: TextStyle(fontSize: 18,color: ThemeColors.homescreenfont),
                          ),
                          Text(
                            'For Your Exercise Plan',
                            style: TextStyle(fontSize: 18,color: ThemeColors.homescreenfont),
                          ),
                          SizedBox(height: 10),
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return DropdownButton<String>(
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: List.generate(7, (index) {
                                  return DropdownMenuItem<String>(
                                    value: (index + 1).toString(),
                                    child: Container(color: ThemeColors.primary,
                                      child: Text((index + 1).toString(),style: TextStyle(color: ThemeColors.homescreenfont),)),
                                  );
                                }),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Keywords: ',style: TextStyle(color: ThemeColors.homescreenfont),),
                              DropdownButton<Keyword>(
                                hint: Text('Select items',style: TextStyle(color: ThemeColors.homescreenfont),),
                                value: null,
                                onChanged: (Keyword? newValue) {
                                  setState(() {
                                    if (newValue != null &&
                                        !selectedBottomDropdownValues
                                            .contains(newValue) &&
                                        !addedItems.contains(newValue)) {
                                      selectedBottomDropdownValues.add(newValue);
                                      addedItems.remove(newValue);
                                    }
                                  });
                                },
                                items:
                                    All_Keywords.map<DropdownMenuItem<Keyword>>(
                                        (Keyword value) {
                                  return DropdownMenuItem<Keyword>(
                                    value: value,
                                    child: Text(value.keyword,style: TextStyle(color: Colors.black),),
                                  );
                                }).toList(),
                              ),
                              IconButton(
                                icon: Text('+',style: TextStyle(color: ThemeColors.homescreenfont),),
                                onPressed: () {
                                  if (selectedBottomDropdownValues.isNotEmpty) {
                                    addedItems
                                        .addAll(selectedBottomDropdownValues);
                                    selectedBottomDropdownValues.clear();
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (var item in addedItems)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Text(item.keyword,style: TextStyle(color: ThemeColors.homescreenfont),),
                                        IconButton(
                                          iconSize: 15,
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              addedItems.remove(item);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.primary,
                              side: BorderSide(color: ThemeColors.homescreenfont,width: 2)
                            ),
                            onPressed: () {
                              if (addedItems.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Add at least 1 keyword!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else if (planNameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Enter a name for the plan!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                MyWorkoutPlan = WorkoutPlan(
                                    1,
                                    DateTime.now(),
                                    planNameController.text,
                                    int.parse(selectedValue));
                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateExerciseDietPlans(
                                      selectedValue,
                                      addedItems,
                                      planNameController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text('Create',style: TextStyle(color: ThemeColors.homescreenfont),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
