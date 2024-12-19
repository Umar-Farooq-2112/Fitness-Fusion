import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'buildWelcomeBlock.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'buildCurrentPlansBlock.dart';
import 'WeightHeightSelectorDialog.dart';

class homeScreenBody extends StatefulWidget {
  @override
  State<homeScreenBody> createState() => homeScreenBodyState();
}

class homeScreenBodyState extends State<homeScreenBody> {

  static   const double conversionFactor = 0.393701;
  double weight = MyUser.weight;
  late int heightFt = ((MyUser.height * conversionFactor)/12).floor();
  late double heightInch = (MyUser.height * conversionFactor)%12;
  var bmi;
  String? bmiText;
  Color? bmiTextColour;

  @override
  Widget build(BuildContext context) {
    var weightString = '$weight kg';
    var heightString = '$heightFt ft ${heightInch.toStringAsFixed(2)} inches';

    var height = (((heightFt * 12) + heightInch) * 0.0254);
    var BMI = (weight / (height * height)).toStringAsFixed(1);
    bmi = double.parse(BMI);
    setBMIText();
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: buildWelcomeBlock(screenWidth),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'BMI',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: ThemeColors.homescreenfont
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrettyGauge(
                                gaugeSize: screenWidth * 0.3,
                                minValue: 0,
                                maxValue: 40,
                                segments: [
                                  GaugeSegment(
                                      'UnderWeight', 18.5, Colors.blue),
                                  GaugeSegment('Healthy', 6.4, Colors.green),
                                  GaugeSegment('OverWeight', 5, Colors.orange),
                                  GaugeSegment('Obese', 10.1, Colors.red),
                                ],
                                valueWidget: Text(
                                  BMI,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ThemeColors.homescreenfont
                                  ),
                                ),
                                currentValue: double.parse(BMI),
                                needleColor: ThemeColors.homescreenfont,
                              ),
                            ],
                          ),
                          Text(
                            bmiText!,
                            style:
                            TextStyle(fontSize: 18, color:ThemeColors.homescreenfont),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            width: screenWidth,
                            height: screenWidth * 0.20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Weight',
                                          style: TextStyle(
                                            color: ThemeColors.homescreenfont,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '$weightString',
                                          style: TextStyle(
                                            color: ThemeColors.homescreenfont,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Height',
                                          style: TextStyle(
                                            color: ThemeColors.homescreenfont,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '$heightString',
                                          style: TextStyle(
                                            color: ThemeColors.homescreenfont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: FaIcon(
                                    FontAwesomeIcons.solidPenToSquare,
                                    color: ThemeColors.homescreenfont,
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
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildCurrentPlansBlock(screenWidth, context),
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
          backgroundColor: ThemeColors.homescreenfont,
          contentPadding: EdgeInsets.all(8.0),
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'BMI Calculator',
            style: TextStyle(
              color: ThemeColors.homescreenfont,
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
