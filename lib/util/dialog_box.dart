import 'package:flutter/material.dart';
import 'my_button.dart';
import 'package:select_form_field/select_form_field.dart';

class DialogBox extends StatelessWidget {
  final controller1;
  final controller2;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.onSave,
    required this.onCancel,
  });
  final List<Map<String, dynamic>> _items = [
    {'value': 'Bassa',},
    {'value': 'Media',},
    {'value': 'Alta',},
  ];
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.deepPurple[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            TextFormField(
              controller: controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nuovo compito',
              ),
            ),
            SelectFormField(
              controller: controller2,
              type: SelectFormFieldType.dropdown,

              items: _items,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Priorita',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                MyButton(text: "Annulla", onPressed: onCancel),
                const SizedBox(width: 8),
                MyButton(text: "Salva", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
