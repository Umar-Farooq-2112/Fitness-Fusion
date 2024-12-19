import 'package:fitness_fusion/database/profileOptions.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CalculateBMIScreen.dart';
import 'NameSelectorDialog.dart';
import 'PassWordSelectorDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'dataclass/User.dart';

class profileScreenBody extends StatefulWidget {
  @override
  State<profileScreenBody> createState() => profileScreenBodyState();
}

class profileScreenBodyState extends State<profileScreenBody> {
  String FeedBack = "";
  var feedBackController = TextEditingController();

  var name = MyUser.name;
  var password = MyUser.password;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ThemeColors.primary,
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: ThemeColors.profilescreenfont,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Container(
        color: ThemeColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: screenWidth,
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 20,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      tileColor: Colors.black,
                      title: Text(
                        'Change Name',
                        style: TextStyle(
                          color: ThemeColors.profilescreenfont,
                          fontSize: 20.0,
                        ),
                      ),
                      trailing: InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.solidPenToSquare,
                          color: ThemeColors.profilescreenfont,
                        ),
                        onTap: () {
                          changeName(context, screenWidth);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      tileColor: ThemeColors.primary,
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: ThemeColors.profilescreenfont,
                          fontSize: 20,
                        ),
                      ),
                      trailing: InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.solidPenToSquare,
                          color: ThemeColors.profilescreenfont,
                        ),
                        onTap: () {
                          changePassword(context, screenWidth);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      tileColor: ThemeColors.primary,
                      title: Text(
                        'Calculate BMI',
                        style: TextStyle(
                          color: ThemeColors.profilescreenfont,
                          fontSize: 20.0,
                        ),
                      ),
                      trailing: InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.solidPenToSquare,
                          color: ThemeColors.profilescreenfont,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => calculateBMI()),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 20,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      tileColor: Colors.black,
                      title: Text(
                        'Submit Feedback',
                        style: TextStyle(
                          color: ThemeColors.profilescreenfont,
                          fontSize: 20.0,
                        ),
                      ),
                      trailing: InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.solidPenToSquare,
                          color: ThemeColors.profilescreenfont,
                        ),
                        onTap: () {
                          submitFeedBack(context, screenWidth);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //***************   For Changing Name   **************************************
  void changeName(BuildContext context, double screenWidth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Change Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenWidth * 0.5),
            child: NameSelectorDialog(
              initialName: name,
              onNameChanged: (newName) {
                setState(() {
                  name = newName;
                });
              },
            ),
          ),
        );
      },
    );
  }

//***************   For Changing Password   ************************************
  void changePassword(BuildContext context, double screenWidth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Change Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenWidth * 0.7),
            child: PasswordSelectorDialog(
              initialPassword: MyUser.password,
              onPasswordChanged: (newPassword) {
                setState(() {
                  password = newPassword;
                });
              },
            ),
          ),
        );
      },
    );
  }

  //***************   For Recording Feedback   **************************************
  void submitFeedBack(BuildContext context, double screenWidth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: SingleChildScrollView(
            // color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: screenWidth * 0.05,
                  ),
                  Text(
                    'Feedback',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  TextField(
                    controller: feedBackController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText:
                          'Enter your feedback regarding Fitness Fusion here',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      hintMaxLines: 2,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FeedBack = feedBackController.text;

                      if (FeedBack != "") {
                        uploadFeedbackDB(
                            context, MyUser, feedBackController.text);
                        Fluttertoast.showToast(
                          msg: 'Feedback Recorded!',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        feedBackController.clear();
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Kindly Enter Your Feedback',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
