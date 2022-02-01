import 'package:flutter/material.dart';
import 'package:todo/data/task.dart';
import 'package:todo/model/task_repository.dart';
import 'package:todo/view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;

  List<Task> selectedTaskList = [];
  bool isSorted = false;
  bool isFinishedTasksIncluded = false;

  Task? currentTask;

  void addNewTask(
    String title,
    String detail,
    DateTime limitDataTime,
    bool isImportant,
  ) {
    repository.addNewTask(
      title,
      detail,
      limitDataTime,
      isImportant,
    );
    getTaskList();
  }

  void getTaskList() {
    selectedTaskList = repository.getTaskList(
      isSorted,
      isFinishedTasksIncluded,
    );
    notifyListeners();
  }

  void sort(bool isSort) {
    isSorted = isSort;
    getTaskList();
  }

  void finishTask(Task selectedTask, isFinished) {
    repository.finishTask(selectedTask,isFinished);
    getTaskList();
  }

  void deleteTask(Task selectedTask) {
    repository.deleteTask(selectedTask);
    getTaskList();
  }

  undo() {
    repository.undo();
    getTaskList();
  }

  changeFinishStatus(bool isIncluded) {
    isFinishedTasksIncluded = isIncluded;
    getTaskList();
  }

  void setCurrentTask(Task selectedTask) {
    currentTask = selectedTask;
    notifyListeners();

  }


}
