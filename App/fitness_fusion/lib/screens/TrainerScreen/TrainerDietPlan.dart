import 'package:fitness_fusion/database/keywordsPlan.dart';
import 'package:fitness_fusion/database/retrieveDietPlan.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/screens/UserScreen/buildAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodData {
  double quantity;
  TimeOfDay time;

  FoodData(this.quantity, this.time);
}

class TrainerDietPlan extends StatefulWidget {
  List<Keyword> keywords;
  TrainerDietPlan(this.keywords);

  @override
  State<TrainerDietPlan> createState() => _TrainerDietPlanState(keywords);
}

class _TrainerDietPlanState extends State<TrainerDietPlan> {
  List<Meal> addMeal = [];
  List<Keyword> keywords;
_TrainerDietPlanState(this.keywords);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      'Add Food Items',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChooseFoodItem(All_Food_Items);
                          },
                        ),
                      );
                      if (result != null) {
                        FoodItem selectedFoodItem = result['food'];
                        TimeOfDay selectedTime = result['time'];
                        double quantity = result['quantity'];
                        addMeal.add(
                            Meal(selectedFoodItem, quantity, selectedTime));
                        setState(() {});
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      MyDietPlan = DietPlan(1, DateTime.now(), 'Diet Plan');
                      for (Meal item in addMeal) {
                        MyDietPlan.Foods.add(
                            Meal(item.item, item.quantity, item.time));
                      }

                      int id = await storeDietPlan(context, MyDietPlan);
                      if (id!=-1){
                        insertDietKeywords(keywords, id);
                      }
                      Fluttertoast.showToast(
                        msg: "Plan Saved!",
                        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                        gravity: ToastGravity
                            .BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                        timeInSecForIosWeb:
                            1, // the duration in seconds that the toast should be displayed
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfff173e8),
                      Color(0xff17e8e8),
                    ],
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: addMeal.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        tileColor: Colors.black,
                        leading: Text(
                          '${addMeal[index].time.hour}:${addMeal[index].time.minute}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${addMeal[index].item.name}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Quantity: ${addMeal[index].quantity} g',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FoodData?> _showInputDialog(BuildContext context,
      {FoodData? initialValue}) async {
    TextEditingController hourController =
        TextEditingController(text: initialValue?.toString() ?? '');
    TextEditingController minuteController =
        TextEditingController(text: initialValue?.toString() ?? '');
    TextEditingController quantityController =
        TextEditingController(text: initialValue?.toString() ?? '');

    return showDialog<FoodData?>(
      context: context,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: Center(child: Text('Meal Information')),
          content: Container(
            height: screenHeight * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('24 Hour Format'),
                    TextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Hour'),
                    ),
                    TextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Minutes'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Amount In Grams'),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Quantity'),
                    ),
                  ],
                ),
              ],
            ),
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
                int enteredHour = int.tryParse(hourController.text) ?? -1;
                int enteredMinute = int.tryParse(minuteController.text) ?? -1;
                double enteredQuantity =
                    double.tryParse(quantityController.text) ?? -1;
                if (enteredHour >= 0 &&
                    enteredHour <= 23 &&
                    enteredMinute >= 0 &&
                    enteredMinute <= 59 &&
                    enteredQuantity > 0) {
                  TimeOfDay timeOfDay =
                      TimeOfDay(hour: enteredHour, minute: enteredMinute);
                  FoodData foodData = FoodData(enteredQuantity, timeOfDay);
                  Navigator.of(context).pop(foodData);
                } else {
                  // Show an error message or handle invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invalid input!',
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

  Widget ChooseFoodItem(List<FoodItem> foodItems) {
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
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  tileColor: Colors.black,
                  title: Text(
                    foodItems[index].name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: foodItems[index].image,
                  onTap: () async {
                    FoodData? foodInfo = await _showInputDialog(context);

                    if (foodInfo != null) {
                      FoodItem selectedFood = foodItems[index];

                      Navigator.of(context).pop({
                        'time': foodInfo.time,
                        'food': selectedFood,
                        'quantity': foodInfo.quantity
                      });
                    }
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 4, thickness: 0);
            },
            itemCount: foodItems.length,
          ),
        ),
      ),
    );
  }
}
