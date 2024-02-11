import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowKeywords extends StatefulWidget {
  @override
  State<ShowKeywords> createState() => _ShowKeywordsState();
}

class _ShowKeywordsState extends State<ShowKeywords> {
  List<Keyword> addedItems = [];
  List<Keyword> selectedBottomDropdownValues = [];

  @override
  Widget build(BuildContext context) {
    All_Keywords.where((item) => !addedItems.contains(item)).toList();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: screenWidth,
                width: screenWidth * 0.8,
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the borderRadius as needed
                  ),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Choose Keywords That',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text(
                              'Best Suit Your Needs ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton<Keyword>(
                                  hint: Text('Select items'),
                                  value: null,
                                  onChanged: (Keyword? newValue) {
                                    setState(() {
                                      if (newValue != null &&
                                          !selectedBottomDropdownValues
                                              .contains(newValue) &&
                                          !addedItems.contains(newValue)) {
                                        selectedBottomDropdownValues
                                            .add(newValue);
                                        addedItems.remove(newValue);
                                      }
                                    });
                                  },
                                  items: All_Keywords
                                      .map<DropdownMenuItem<Keyword>>(
                                          (Keyword value) {
                                    return DropdownMenuItem<Keyword>(
                                      value: value,
                                      child: Text(value.keyword),
                                    );
                                  }).toList(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    if (selectedBottomDropdownValues
                                        .isNotEmpty) {
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
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var item in addedItems)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(item.keyword),
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
                              onPressed: () {
                                if (addedItems.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: 'Add atleast 1 Keyword please!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    // or Toast.LENGTH_LONG
                                    gravity: ToastGravity.CENTER,
                                    // Also possible: TOP, CENTER
                                    timeInSecForIosWeb: 1,
                                    // ignored in Android
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  //use addedItems list
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
