import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/common/show_add_new_task.dart';
import 'package:todo/view/common/show_snack_bar.dart';
import 'package:todo/view/detail/detail_screen.dart';
import 'package:todo/view/side_menu/side_menu_page.dart';
import 'package:todo/view/style.dart';
import 'package:todo/view/task_list/task_list_tile_part.dart';
import 'package:todo/view_model/view_model.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future(() {
      final viewModel = context.read<ViewModel>();
      viewModel.getTaskList();
    });

    return Consumer<ViewModel>(
      builder: (context, vm, child) {
        final screenSize = vm.screenSize;
        final selectedTaskList = vm.selectedTaskList;
        final isSorted = vm.isSorted;

        return Scaffold(
          backgroundColor: CustomColors.taskListBgColor,
          appBar: AppBar(
            title: Text(StringR.taskList),
            centerTitle: true,
            actions: [
              (isSorted)
                  ? IconButton(
                      icon: Icon(Icons.undo),
                      onPressed: () => _sort(context, false),
                    )
                  : IconButton(
                      icon: Icon(Icons.sort),
                      onPressed: () => _sort(context, true),
                    ),
            ],
          ),
          floatingActionButton: (screenSize == ScreenSize.LARGE)
              ? null
              : FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _addNewTask(context),
                ),
          drawer: (screenSize != ScreenSize.LARGE)
              ? Drawer(
                  child: SideMenuPage(),
                )
              : null,
          body: ListView.builder(
              itemCount: selectedTaskList.length,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                final task = selectedTaskList[index];

                final now = DateTime.now();
                final limit = task.limitDateTime;

                return Card(
                  color: (now.compareTo(limit) > 0)
                      ? CustomColors.periodOverTaskColor
                      : CustomColors.taskCardBgColor(context),
                  child: (DeviceInfo.isWebOrDesktop)
                      ? _createTaskListTile(context, task)
                      : Slidable(
                          child: _createTaskListTile(context, task),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            extentRatio: 0.65,
                            children: [
                              SlidableAction(
                                label: StringR.edit,
                                icon: Icons.edit,
                                onPressed: (context) => _showTaskDetail(context,task),
                              ),
                              SlidableAction(
                                label: StringR.delete,
                                icon: Icons.delete,
                                onPressed: (context) => _deleteTask(context,task),
                              ),
                              SlidableAction(
                                label: StringR.close,
                                icon: Icons.close,
                                onPressed: null,
                              ),
                            ],
                          ),
                        ),
                );
              }),
        );
      },
    );
  }

  Widget _createTaskListTile(BuildContext context, Task task) {
    return TaskListTilePart(
      task: task,
      onFinishChanged: (isFinished) => _finishTask(context, isFinished, task),
      onDelete: () => _deleteTask(context, task),
      onEdit: () => _showTaskDetail(context, task),
    );
  }

  _sort(BuildContext context, bool isSort) {
    final viewModel = context.read<ViewModel>();
    viewModel.sort(isSort);
  }

  //TODO
  _addNewTask(BuildContext context) {
    showAddNewTask(context);
  }

  _finishTask(BuildContext context, isFinished, Task selectedTask) {
    if (isFinished == null) return;
    final viewModel = context.read<ViewModel>();
    viewModel.finishTask(selectedTask, isFinished);

    showSnackBar(
      context: context,
      contentText: StringR.finishTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );
    viewModel.setCurrentTask(null);
  }

  _deleteTask(BuildContext context, Task selectedTask) {
    final viewModel = context.read<ViewModel>();
    viewModel.deleteTask(selectedTask);

    showSnackBar(
      context: context,
      contentText: StringR.deleteTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );
    viewModel.setCurrentTask(null);
  }

  _showTaskDetail(BuildContext context, Task selectedTask) {
    final viewModel = context.read<ViewModel>();
    final screenSize = viewModel.screenSize;
    viewModel.setCurrentTask(selectedTask);

    if (screenSize == ScreenSize.SMALL) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(),
        ),
      );
    }
  }
}
