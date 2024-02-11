import 'package:fitness_fusion/database/profileOptions.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameSelectorDialog extends StatefulWidget {
  final String initialName;
  final Function(String) onNameChanged;

  NameSelectorDialog({
    required this.initialName,
    required this.onNameChanged,
  });

  @override
  _NameSelectorDialogState createState() => _NameSelectorDialogState();
}

class _NameSelectorDialogState extends State<NameSelectorDialog> {
  late String name;
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = widget.initialName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text('Previous Name'),
          title: Text('$name'),
        ),
        ListTile(
          leading: Text('New Name'),
          title: TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
              onPressed: () {
                var NameText = nameController.text;
                setState(
                      () {
                    if (NameText != "") {
                      name = NameText;
                      widget.onNameChanged(name);
                      nameController.clear();
                      Navigator.of(context).pop();
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Kindly Enter Your Name',
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

              changeNameDB(context, MyUser, name);

              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ]),
      ],
    );
  }
}
