import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
// list of todo task
  List toDoList = [];
  // reference the hive box
  final myBox = Hive.box("My box");

  //run this method if this is the first time ever opening this app
  void createInitialData(){
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false]
    ];
  }

  //load data from the database
void loadData(){
   toDoList = myBox.get("TODOLIST");
}

//update the database
void updateDatabase(){
   myBox.put("TODOLIST", toDoList);
}
}