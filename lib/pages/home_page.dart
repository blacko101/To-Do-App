import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_doapp/data/database.dart';
import 'package:to_doapp/util/dialog_box.dart';
import 'package:to_doapp/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // reference the hive box
  final myBox = Hive.box("My box");
  ToDoDatabase db =ToDoDatabase();

  @override
  void initState() {
    //if this the first time opening the app, then create default data
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    else {
      //there already exist data
      db.loadData();
  }
    super.initState();
  }
//text controller
final controller =TextEditingController();



  //checkBox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateDatabase();
  }
// save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
  //create New task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
controller: controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
  }
  );
}

//delete  task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text("To Do")),
        elevation: 0,
        backgroundColor: Colors.yellow,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        }
      ),
      );
  }
}
