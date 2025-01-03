import 'package:fitness_fusion/database/UserRegistation.dart';
import 'package:fitness_fusion/database/requestTrainer.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';
// import 'package:date_field/date_field.dart';

class TrainerRequest extends StatefulWidget {
  const TrainerRequest({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TrainerRequestState createState() => _TrainerRequestState();
}

class _TrainerRequestState extends State<TrainerRequest> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _password1Controller = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _dobController = TextEditingController();

  String? _selectedGender;

  bool view = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primary,
      appBar: AppBar(
        title: const Text('FitnessFusion'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _usernameController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    obscureText: view,
                    controller: _password1Controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.loginTextFieldFont,
                        ),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                            view ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            view = !view;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    obscureText: view,
                    controller: _password2Controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeColors.loginTextFieldFont,
                        ),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: 'Repeat Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                            view ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            view = !view;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _nameController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _dobController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: null,
                        firstDate: DateTime(1950),
                        lastDate: DateTime(DateTime.now().year - 15),
                      );

                      if (selectedDate != null) {
                        setState(() {
                          _dobController.text = selectedDate.year.toString() +
                              "-" +
                              selectedDate.month.toString() +
                              "-" +
                              selectedDate.day.toString();
                        });
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Date of Birth'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _heightController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Height (cm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _weightController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Weight (KG)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(1, 1)),
                    value: _selectedGender,
                    hint: Text(
                      'Gender',
                      style:
                          TextStyle(color: Colors.grey),
                    ),
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(
                          gender,
                          style:
                              TextStyle(color: ThemeColors.loginTextFieldFont),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Choose Gender';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _emailController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    controller: _phoneController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 192, 224))),
                        border: const UnderlineInputBorder(),
                        labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: ThemeColors.loginTextFieldFont)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary),
                    onPressed: () async {
                      if (_usernameController.text.isNotEmpty &&
                          _password1Controller.text.isNotEmpty &&
                          _password2Controller.text.isNotEmpty &&
                          _nameController.text.isNotEmpty &&
                          _heightController.text.isNotEmpty &&
                          _weightController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _dobController.text.isNotEmpty &&
                          _selectedGender != null) {
                        if (_usernameController.text.contains(' ')) {
                          createDialog(
                              context, "Username cannot have white Spaces");
                        } else if (_password1Controller.text !=
                            _password2Controller.text) {
                          createDialog(context, "Passowrd Does not match");
                        } else if (double.tryParse(_heightController.text) ==
                                null ||
                            double.tryParse(_weightController.text) == null ||
                            double.parse(_heightController.text) < 122 ||
                            double.parse(_weightController.text) < 20) {
                          createDialog(context, "Invalid Height Or Weight");
                        } else if (!_emailController.text.contains('@')) {
                          createDialog(context, "Invalid Email Address");
                        } else {
                          String temp = _phoneController.text;
                          if (_phoneController.text[0] == '+') {
                            temp = temp.substring(1);
                          }
                          if (int.tryParse(temp) == null) {
                            createDialog(context, "Invalid Phone Number");
                          } else {
                            if (await ifUserPresent(
                                     _usernameController.text) !=
                                0) {
                              createDialog(context, "Username Already Present");
                            } else {
                              User input = new User(
                                  0,
                                  _usernameController.text,
                                  _password1Controller.text,
                                  _nameController.text,
                                  _selectedGender!,
                                  double.parse(_weightController.text),
                                  double.parse(_heightController.text),
                                  _dobController.text,
                                  "Trainer",
                                  _emailController.text,
                                  _phoneController.text);

                              if (await requestTrainer(input)) {
                                Navigator.of(context).pop();
                                createDialog(context, "Request Added");
                              } else {
                                createDialog(context, "Unable to Request");
                              }
                            }
                          }
                        }
                      } else {
                        createDialog(context, "All fields must be filled");
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: ThemeColors.loginTextFieldFont),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
