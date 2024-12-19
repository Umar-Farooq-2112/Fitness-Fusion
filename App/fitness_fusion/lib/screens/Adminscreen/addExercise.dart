import 'dart:io';
import 'dart:typed_data';

import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/screens/Adminscreen/mywidgets.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddExercise extends StatefulWidget {
  final List<Exercises> exercises;

  const AddExercise({required this.exercises, Key? key}) : super(key: key);

  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name;
  late String _description;
  // ignore: unused_field
  late Uint8List _gifData;

  late String _bodyPart = "1";
  late String _bodyDomain = "1";
  late bool _isPush = false;
  late String _equipment;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 245, 245),
      appBar: buildAppBar(screenHeight, screenWidth),
      body: buildForm(),
    );
  }

  Widget buildForm() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    buildTextFormField(
                      label: 'Exercise Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    buildTextFormField(
                        keyboardType: TextInputType.text,
                        label: 'Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Targeted Body Part',
                            border: OutlineInputBorder()),
                        value: _bodyPart,
                        items: const [
                          DropdownMenuItem(
                              value: '1', child: Text('Upper Chest')),
                          DropdownMenuItem(
                              value: '2', child: Text('Middle Chest')),
                          DropdownMenuItem(
                              value: '3', child: Text('Lower Chest')),
                          DropdownMenuItem(
                              value: '4', child: Text('Inner Chest')),
                          DropdownMenuItem(value: '5', child: Text('Biceps')),
                          DropdownMenuItem(value: '6', child: Text('Triceps')),
                          DropdownMenuItem(value: '7', child: Text('ForeArms')),
                          DropdownMenuItem(
                              value: '8', child: Text('Upper Abs')),
                          DropdownMenuItem(
                              value: '9', child: Text('Lower Abs')),
                          DropdownMenuItem(
                              value: '10', child: Text('Obliques')),
                          DropdownMenuItem(
                              value: '11', child: Text('Upper Back')),
                          DropdownMenuItem(
                              value: '12', child: Text('Lower Back')),
                          DropdownMenuItem(value: '13', child: Text('Lats')),
                          DropdownMenuItem(
                              value: '14', child: Text('Front Delts')),
                          DropdownMenuItem(
                              value: '15', child: Text('Lateral Delts')),
                          DropdownMenuItem(
                              value: '16', child: Text('Rear Delts')),
                          DropdownMenuItem(value: '17', child: Text('Traps')),
                          DropdownMenuItem(value: '18', child: Text('Quads')),
                          DropdownMenuItem(value: '19', child: Text('Calves')),
                          DropdownMenuItem(value: '20', child: Text('Glutes')),
                          DropdownMenuItem(
                              value: '21', child: Text('Hamstrings')),
                          DropdownMenuItem(value: '22', child: Text('Hybrid')),
                          DropdownMenuItem(value: '23', child: Text('Hybrid')),
                          DropdownMenuItem(value: '24', child: Text('Hybrid')),
                          DropdownMenuItem(value: '25', child: Text('Hybrid')),
                          DropdownMenuItem(value: '26', child: Text('Hybrid')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _bodyPart = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a body part';
                          }
                          return null;
                        },
                      ),
                    ),
                    buildSwitchListTile(
                        title: 'Is it a Push Exercise?',
                        value: _isPush,
                        onChanged: (value) {
                          setState(() {
                            _isPush = value;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Equipment',
                            border: OutlineInputBorder()),
                        value: _bodyDomain,
                        items: const [
                          DropdownMenuItem(
                              value: '1', child: Text('Bodyweight')),
                          DropdownMenuItem(value: '2', child: Text('Dumbbell')),
                          DropdownMenuItem(value: '3', child: Text('Barbell')),
                          DropdownMenuItem(value: '4', child: Text('Machine'))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _bodyDomain = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an Equipment';
                          }
                          return null;
                        },
                      ),
                    ),
                    buildFilePickerButton(),
                    const SizedBox(height: 20),
                    RoundButton(
                      btnName: 'Save',
                      bgcolor: Colors.grey,
                      callBack: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilePickerButton() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundButton(
            btnName: ' Pick a GIF',
            bgcolor: Colors.grey,
            callBack: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['gif'],
              );
                print("HEllooo4");
                print("HEllooo4");
                print("HEllooo4");

              if (result != null) {
                print("HEllooo");
                print("HEllooo");
                print("HEllooo");
                String filePath = result.files.single.path!;
                File gifFile = File(filePath);
                Uint8List gifBytes = await gifFile.readAsBytes();
                print("Gid Loaded Successfully:  ${result.files.single.path}");
                setState(() {
                  _gifData = gifBytes; // Store the file bytes
                });
              }
            }));
  }


  Widget buildTextFormField({
    required String label,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget buildSwitchListTile({
    required String title,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: SwitchListTile(
          title: Text(title),
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Exercises newExercise = Exercises(
        0,
        _name,
        _description,
        Image.asset('assets/images/logo.png'),
        _bodyPart,
        _bodyDomain,
        _isPush,
        _equipment,
      );

      setState(() {
        widget.exercises.add(newExercise);
      });
      // File file = File(_gifPath); // Replace with the actual path to your file
      // createDialog(context, "Added");
      // var contents = await file.readAsBytes();

      // file = Image.

      Navigator.pop(context); // Close the form after saving
    }
  }
}
