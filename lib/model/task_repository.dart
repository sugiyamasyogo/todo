import 'package:todo/data/task.dart';

class TaskRepository {
  void addNewTask(
    String title,
    String detail,
    DateTime limitDataTime,
    bool isImportant,
  ) {
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

  List<Task> getTaskList(
    bool isSorted,
    bool isFinishedTasksIncluded,
  ) {
    var returnList = <Task>[];
    returnList = getBaseTaskList(isFinishedTasksIncluded);

    //TODO 「重要」でソート
    if(isSorted){
      return sortByImportant(returnList);
    }
    return returnList;
  }

  List<Task> getBaseTaskList(bool isFinishedTasksIncluded) {
    baseTaskList.sort((a,b) => a.limitDateTime.compareTo(b.limitDateTime));

    //TODO 完了すみタスクを含む・含まないの処理
    return baseTaskList;
  }

  List<Task> sortByImportant(List<Task> taskList) {
    //taskList.sort((a , b) => (a.isImportant) ? -1 : 1);
    final subListImportant = taskList.where((task) => task.isImportant == true).toList();
    final subListNotImportant =taskList.where((task) => task.isImportant == false).toList();

    subListImportant.sort((a,b) => a.limitDateTime.compareTo(b.limitDateTime));
    subListNotImportant.sort((a,b) => b.limitDateTime.compareTo(b.limitDateTime));

    taskList = [
      ...subListImportant,
      ...subListNotImportant,
    ];

    return taskList;
  }
}
