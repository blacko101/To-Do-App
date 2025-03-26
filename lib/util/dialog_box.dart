import 'package:flutter/material.dart';
import 'package:to_doapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

   DialogBox({
     super.key,
    required this.controller,
    required this.onSave,
     required this.onCancel,
   });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //getuserinput
          TextField(
            controller: controller,
        decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: "Add new Task",
          ),
          ),
          // button -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // save button
              MyButtons(text: "Save", onPressed: onSave),
              const SizedBox(width: 8),
              // cancel button
              MyButtons(text: "Cancel", onPressed: onCancel)
            ],
          )
        ],
    ),
      ),
    );
  }
}

