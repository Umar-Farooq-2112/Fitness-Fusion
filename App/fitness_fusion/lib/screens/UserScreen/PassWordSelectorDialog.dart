import 'package:fitness_fusion/database/profileOptions.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordSelectorDialog extends StatefulWidget {
  final String initialPassword;
  final Function(String) onPasswordChanged;

  PasswordSelectorDialog({
    required this.initialPassword,
    required this.onPasswordChanged,
  });

  @override
  _PasswordSelectorDialogState createState() => _PasswordSelectorDialogState();
}

class _PasswordSelectorDialogState extends State<PasswordSelectorDialog> {
  late String oldPassword;
  var oldPasswordController = TextEditingController();
  var newPasswordController1 = TextEditingController();
  var newPasswordController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    oldPassword = widget.initialPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text('Previous Password'),
          title: TextField(
            keyboardType: TextInputType.name,
            obscureText: true,
            controller: oldPasswordController,
          ),
        ),
        ListTile(
          leading: Text('New Password'),
          title: TextField(
            keyboardType: TextInputType.name,
            obscureText: true,
            controller: newPasswordController1,
          ),
        ),
        ListTile(
          leading: Text('Confirm Password'),
          title: TextField(
            keyboardType: TextInputType.name,
            obscureText: true,
            controller: newPasswordController2,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
              onPressed: () {
                var oldPText = oldPasswordController.text;
                var newP1Text = newPasswordController1.text;
                var newP2Text = newPasswordController2.text;
                setState(
                      () {
                    if (oldPText != "" &&
                        newP1Text != "" &&
                        newP2Text != "" &&
                        oldPText == oldPassword &&
                        newP1Text == newP2Text) {
                      oldPassword = newP1Text;
                      widget.onPasswordChanged(oldPassword);
                      oldPasswordController.clear();
                      newPasswordController1.clear();
                      newPasswordController2.clear();
                      changePasswordDB(context, MyUser, newP1Text);
                      Navigator.of(context).pop();
                    } else if (oldPText == "" ||
                        newP1Text == "" ||
                        newP2Text == "") {
                      Fluttertoast.showToast(
                        msg: 'Kindly Fill All Fields!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (oldPText != oldPassword) {
                      Fluttertoast.showToast(
                        msg: 'Incorrect Previous Password Entered!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (newP1Text != newP2Text) {
                      Fluttertoast.showToast(
                        msg:
                        'New Password And Repeat Password Fields Do Not Match!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                );
              },
              child: Text('Save')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ]),
      ],
    );
  }
}
