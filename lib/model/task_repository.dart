import 'package:todo/data/task.dart';

class TaskRepository {
  void addNewTask(String title,
      String detail,
      DateTime limitDataTime,
      bool isImportant,) {
    final nextId = getNextId();
    final newTask = Task(
      id: nextId,
      title: title,
      detail: detail,
      limitDateTime: limitDataTime,
      isImportant: isImportant,
      isFinished: false,
    );
    baseTaskList.add(newTask);
  }

  int getNextId() {
    final maxId = baseTaskList
        .reduce((currentTodo, nextTodo) =>
    currentTodo.id > nextTodo.id ? currentTodo : nextTodo)
        .id;
    return maxId + 1;
  }
}