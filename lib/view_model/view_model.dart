import 'package:flutter/material.dart';
import 'package:todo/data/task.dart';
import 'package:todo/model/task_repository.dart';
import 'package:todo/view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;

  void addNewTask(
    String title,
    String detail,
    DateTime limitDataTime,
    bool isImportant,
  ) {
    repository.addNewTask(
      title,detail,limitDataTime,isImportant,
    );
    print("tasks: $baseTaskList");
  }
}
