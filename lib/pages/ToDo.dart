import 'package:app2/data/database.dart';
import 'package:app2/util/dialog_box.dart';
import 'package:app2/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  final _myBox = Hive.box('mybox');

  ToDoDatabase db=ToDoDatabase();

  @override
  void initState() {
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=>Navigator.of(context).pop(),
      );
    });
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 215, 255),
        appBar: AppBar(
          backgroundColor:Colors.blue[300] ,
          elevation: 0,
          centerTitle: true,
          title: Text("TO DO"),
          
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
          
        ),

        body: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskname: db.toDoList[index][0],
              taskcompleted: db.toDoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteFunction: (context)=>deleteTask(index),
            );
          },
        ),
      );
  }
}  