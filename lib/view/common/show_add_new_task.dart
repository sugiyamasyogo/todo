import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/add_task/add_task_page.dart';
import 'package:todo/view/add_task/add_task_screen.dart';
import 'package:todo/view/style.dart';
import 'package:todo/view_model/view_model.dart';

showAddNewTask(BuildContext context) {
  final viewModel = context.read<ViewModel>();
  final screenSize = viewModel.screenSize;

  if (screenSize == ScreenSize.SMALL) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
  } else {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: WidgetSize.addTaskDialogWidth,
          height: WidgetSize.addTaskDialogHeight,
          child: AddTaskPage(),
        ),
      ),
    );
  }
}
