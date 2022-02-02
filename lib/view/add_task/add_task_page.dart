import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/common/show_snack_bar.dart';
import 'package:todo/view/common/task_content_part.dart';
import 'package:provider/provider.dart';
import 'package:todo/view_model/view_model.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final taskContentKey = GlobalKey<TaskContentPartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(StringR.addNewTask),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _onDoneAddNewTask(context),
          ),
        ],
      ),
      body: TaskContentPart(
        isEditMode:false,
        key: taskContentKey,
      ),
    );
  }

  _onDoneAddNewTask(BuildContext context) {
    final taskContentState = taskContentKey.currentState;
    if (taskContentState == null) return;
    if (taskContentState.formKey.currentState!.validate()) {
      final viewModel = context.read<ViewModel>();
      viewModel.addNewTask(
        taskContentState.titleController.text,
        taskContentState.detailController.text,
        taskContentState.limitDataTime,
        taskContentState.isImportant,
      );

      Navigator.pop(context);

      showSnackBar(
        context: context,
        contentText: StringR.addTaskCompleted,
        isSnackBarActionNeeded: false,
      );
    }
  }
}
