import 'package:fitness_fusion/database/DataRetrival.dart';
import 'package:fitness_fusion/database/assignPlans.dart';
import 'package:fitness_fusion/database/keywordsManagement.dart';
import 'package:fitness_fusion/database/login.dart';
import 'package:fitness_fusion/database/requestTrainer.dart';
import 'package:fitness_fusion/database/retrieveDietPlan.dart';
import 'package:fitness_fusion/database/retrieveFeedBack.dart';
import 'package:fitness_fusion/database/retrieveWorkoutPlan.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:fitness_fusion/screens/Adminscreen/adminscreen.dart';
import 'package:fitness_fusion/screens/Authentication/KeywordsPage.dart';
import 'package:fitness_fusion/screens/Authentication/TrainerRequest.dart';
import 'package:fitness_fusion/screens/Authentication/signuppage.dart';
import 'package:fitness_fusion/screens/TrainerScreen/Trainerwindow.dart';
import 'package:fitness_fusion/screens/UserScreen/usermode.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool view = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: AppBar(
        title: const Text('FitnessFusion'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextField(
                          style: TextStyle(
                            color: ThemeColors
                                .loginTextFieldFont, // Change text color here
                          ),
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person)),
                            border: const OutlineInputBorder(),
                            labelText: 'Username',
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextField(
                          style: TextStyle(
                            color: ThemeColors
                                .loginTextFieldFont, // Change text color here
                          ),
                          controller: passwordController,
                          obscureText: this.view,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.password_rounded)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      this.view = !this.view;
                                    });
                                  },
                                  icon: Icon(this.view
                                      ? Icons.visibility
                                      : Icons.visibility_off)))),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Perform login logic here
                              String username = usernameController.text;
                              String password = passwordController.text;

                              // Example: Check if username and password are not empty
                              if (username.isNotEmpty && password.isNotEmpty) {
                                int id = await checkValidPassword(
                                    username, password);

                                if (id == 0) {
                                  createDialog(
                                      context, "Invalid username or Password");
                                } else {
                                  createDialog(context, "Login Successfull");

                                  MyUser = await fetchUserData(context, id);

                                  await fetchAndSetExercises(context);
                                  await fetchAndSetFoodItems(context);
                                  await retrieveKeywords(context);

                                  if (MyUser.type == "Trainee") {
                                    bool st =
                                        await validateUserPlan(MyUser.user_id);

                                    if (!st) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  KeywordSelectionPage()));
                                    }

                                    MyDietPlan = await retrieveDietPlan(
                                        context, MyUser.user_id);
                                    MyWorkoutPlan = await retriveWorkoutPlan(
                                        context, MyUser.user_id);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  } else if (MyUser.type == "Trainer") {
                                    Navigator.pushReplacement(
                                      context, // Use the stored context
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TrainerWindow()),
                                    );
                                  } else if (MyUser.type == "Admin") {
                                    retrieveFeedback(context);
                                    fetchRequests(context);

                                    Navigator.pushReplacement(
                                      context, // Use the stored context
                                      MaterialPageRoute(
                                          builder: (context) => Admin()),
                                    );
                                  }
                                }
                              } else {
                                createDialog(
                                    context, "Please enter all fields");
                              }
                            },
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                BorderSide(
                                    color: ThemeColors.loginButtonColors,
                                    width: 2), // Yellow border of width 2
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                  ThemeColors
                                      .loginFont), // Set background color here
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: ThemeColors.loginButtonColors),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                BorderSide(
                                    color: ThemeColors.loginButtonColors,
                                    width: 2), // Yellow border of width 2
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                  ThemeColors
                                      .loginFont), // Set background color here
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: ThemeColors.loginButtonColors),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                BorderSide(
                                    color: ThemeColors.loginButtonColors,
                                    width: 2), // Yellow border of width 2
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                  ThemeColors
                                      .loginFont), // Set background color here
                            ),
                            onPressed: () {
                              // Example: Check if username and password are not empty
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TrainerRequest()));
                            },
                            child: Text(
                              'Sign Up for Trainers',
                              style: TextStyle(
                                  color: ThemeColors.loginButtonColors),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
