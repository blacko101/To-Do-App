import 'package:flutter/material.dart';
import 'package:to_doapp/util/dialog_box.dart';
import 'package:to_doapp/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
//text controller
final controller =TextEditingController();

  // list of todo task
  List toDoList = [
    ["Make Tutorial", false],
    ["Do Exercise", false]
  ];

  //checkBox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1]=!toDoList[index][1];
    });
  }
// save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
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
      toDoList.removeAt(index);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        }
      ),
      );
  }
}
