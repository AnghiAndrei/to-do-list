import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState(){
    if(_myBox.get("TODOLIST") == null){db.createInitialData();}
      else{db.loadData();}
    super.initState();
  }

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false, _controller2.text]);
      _controller.clear();
      _controller2.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller1: _controller,
          controller2: _controller2,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('TO DO LIST'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty ?
          Center(
            child: Container(
                padding: EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              child: const Text(
                  'Hai finito tutti i compiti\nBuon riposo',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
              )
            )
          )
          : ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            priorita: db.toDoList[index][2],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
