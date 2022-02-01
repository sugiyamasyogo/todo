import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/common/show_add_new_task.dart';
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
              ) : IconButton(
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
                    child: TaskListTilePart(
                      task: task,
                      onFinishChanged: (isFinished) => _finishTask(context,isFinished,task),
                    ));
              }),
        );
      },
    );
  }

  _sort(BuildContext context ,bool isSort) {
    final viewModel = context.read<ViewModel>();
    viewModel.sort(isSort);

  }

  //TODO
  _addNewTask(BuildContext context) {
    showAddNewTask(context);
  }
//TODO
  _finishTask(BuildContext context, isFinished, Task task) {

  }
}
