import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/common/task_content_part.dart';
import 'package:todo/view/style.dart';
import 'package:todo/view_model/view_model.dart';
import 'package:tuple/tuple.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  final taskContentPartKey = GlobalKey<TaskContentPartState>();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, Tuple2<Task?, ScreenSize>>(
      selector: (context, vm) => Tuple2(
        vm.currentTask,
        vm.screenSize,
      ),
      builder: (context, data, child) {
        final selectedTask = data.item1;
        final screenSize = data.item2;

        if (selectedTask != null && screenSize != ScreenSize.SMALL) {
          _updateDetailInfo(selectedTask);
        }

        return Scaffold(
          backgroundColor: CustomColors.detailBgColor,
          appBar: AppBar(
            leading: (selectedTask != null)
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _clearCurrentTask(context);
                      if (screenSize == ScreenSize.SMALL) {
                        Navigator.pop(context);
                      }
                    },
                  )
                : null,
            title: Text(StringR.taskDetail),
            centerTitle: true,
            actions: (selectedTask != null)
                ? [
                    //TODO 編集完了
                    IconButton(
                      icon: Icon(Icons.done),
                      onPressed: null,
                    ),
                    //TODO 削除
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: null,
                    ),
                  ]
                : null,
          ),
          //TODO
          body: (selectedTask != null)
              ? TaskContentPart(
                  key: taskContentPartKey,
                  isEditMode: true,
                  selectedTask: selectedTask,
                )
              : null,
        );
      },
    );
  }

  void _clearCurrentTask(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    viewModel.setCurrentTask(null);
  }

  void _updateDetailInfo(Task selectedTask) {
    final taskContentPartState = taskContentPartKey.currentState;
    if (taskContentPartState == null) return;
    taskContentPartState.taskEditing = selectedTask;
    taskContentPartState.setDetailData();
  }
}
