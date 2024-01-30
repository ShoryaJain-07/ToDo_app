import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList=[
      ["Learn FLutter",true],
      ["Write medium aricle",false],
    ];
  }

  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase(){
    _myBox.put("TODOLIST",toDoList);
  }
}