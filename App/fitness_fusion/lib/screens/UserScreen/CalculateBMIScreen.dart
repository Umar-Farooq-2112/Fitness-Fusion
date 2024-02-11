import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';
import 'buildAppBar.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'WeightHeightSelectorDialog.dart';
class calculateBMI extends StatefulWidget {
  @override
  State<calculateBMI> createState() => _calculateBMIState();
}

class _calculateBMIState extends State<calculateBMI> {
  double weight = 50;
  int heightFt = 5;
  double heightInch = 3;
  var feedBackController = TextEditingController();
  var bmi;
  // var name = 'hehe';
  // var password = '1234';
  var name = MyUser.username;
  var password = MyUser.password;
  String? bmiText;
  Color? bmiTextColour;

  @override
  Widget build(BuildContext context) {
    var weightString = '$weight kg';
    var heightString = '$heightFt ft $heightInch inches';
    var height = (((heightFt * 12) + heightInch) * 0.0254);
    var BMI = (weight / (height * height)).toStringAsFixed(1);
    bmi = double.parse(BMI);
    setBMIText();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          children: [
            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'BMI',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrettyGauge(
                        gaugeSize: screenWidth * 0.4,
                        minValue: 0,
                        maxValue: 40,
                        segments: [
                          GaugeSegment('UnderWeight', 18.5, Colors.blue),
                          GaugeSegment('Healthy', 6.4, Colors.green),
                          GaugeSegment('OverWeight', 5, Colors.orange),
                          GaugeSegment('Obese', 10.1, Colors.red),
                        ],
                        valueWidget: Text(
                          BMI,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        currentValue: double.parse(BMI),
                        needleColor: Colors.black,
                      ),
                    ],
                  ),
                  Text(
                    bmiText!,
                    style: TextStyle(fontSize: 20, color: bmiTextColour!),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: screenWidth,
                    height: screenWidth * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Weight',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '$weightString',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Height',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '$heightString',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          child: FaIcon(
                            FontAwesomeIcons.solidPenToSquare,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setNewWeightHeight(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setBMIText() {
    if (bmi >= 30) {
      bmiText = 'Obese';
      bmiTextColour = Colors.red;
    } else if (bmi >= 25) {
      bmiText = 'OverWeight';
      bmiTextColour = Colors.orange;
    } else if (bmi >= 18.5) {
      bmiText = 'Normal';
      bmiTextColour = Colors.green;
    } else if (bmi < 18.5) {
      bmiText = 'UnderWeight';
      bmiTextColour = Colors.blue;
    }
  }

  void setNewWeightHeight(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8.0),
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'BMI Calculator',
            style: TextStyle(
              fontWeight: FontWeight.w200,
            ),
          ),
          content: WeightHeightSelectorDialog(
            initialWeight: weight,
            initialHeightFt: heightFt,
            initialHeightInch: heightInch,
            onWeightHeightChanged: (newWeight, newHeightFt, newHeightInch) {
              setState(() {
                weight = newWeight;
                heightFt = newHeightFt;
                heightInch = newHeightInch;
              });
            },
          ),
        );
      },
    );
  }
}

