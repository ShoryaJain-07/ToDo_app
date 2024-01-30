import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {

  final String taskname;

  final bool taskcompleted;

  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

 ToDoTile({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    required this.onChanged,
    required this.deleteFunction,
    });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),)
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
        
              Checkbox(value: taskcompleted, onChanged: onChanged),
        
              Text(taskname,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: taskcompleted? TextDecoration.lineThrough:TextDecoration.none,
                  )),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(12),
            ),
        ),
      ),
    );
  }
}