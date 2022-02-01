import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/style.dart';
import 'package:todo/view_model/view_model.dart';
import 'package:tuple/tuple.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

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

        return Scaffold(
          backgroundColor: CustomColors.detailBgColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              //TODO 閉じる
              onPressed: null,
            ),
            title: Text(StringR.taskDetail),
            centerTitle: true,
            actions : [
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
            ],
          ),
          //TODO
          body: ListTile(
            title: Text(selectedTask?.title ?? ""),
            subtitle: Text(selectedTask?.limitDateTime.toString() ?? ""),
          ),
        );
      },
    );
  }
}
