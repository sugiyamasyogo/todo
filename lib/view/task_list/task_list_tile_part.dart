import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/functions.dart';

class TaskListTilePart extends StatelessWidget {
  final Task task;

   TaskListTilePart({Key? key , required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(
          convertDateTimeToString(task.limitDateTime),
      ),
    );
  }
}
