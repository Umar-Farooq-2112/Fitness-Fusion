import 'package:fitness_fusion/database/keywordsManagement.dart';
import 'package:fitness_fusion/dataclass/createDialog.dart';
import 'package:flutter/material.dart';

void addKeywords(BuildContext context) {
  TextEditingController kwController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add new Keyword'),
        content: Container(
          child: TextField(
              controller: kwController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.person)),
                border: const OutlineInputBorder(),
                labelText: 'Keyword',
              )),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!kwController.text.isEmpty){
              await addKeyword(context,kwController.text);
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Close the dialog
              }else{
                showToast("Invalid Input");
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
