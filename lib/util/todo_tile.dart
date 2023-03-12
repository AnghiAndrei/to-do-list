import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String priorita;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.priorita,
    required this.onChanged,
    required this.deleteFunction,
  });

  Color colore(String priorita) {
    if (priorita=="Bassa")return Colors.greenAccent;
    if (priorita=="Media")return Colors.yellow;
    if (priorita=="Alta") return Colors.redAccent;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.grey,
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colore(priorita as String),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.black,
                side: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontStyle: taskCompleted ? FontStyle.italic : FontStyle.normal,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
