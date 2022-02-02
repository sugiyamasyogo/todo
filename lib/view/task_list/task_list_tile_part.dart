import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/util/functions.dart';
import 'package:todo/view/style.dart';

class TaskListTilePart extends StatelessWidget {
  final Task task;
  final ValueChanged onFinishChanged;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskListTilePart({
    Key? key,
    required this.task,
    required this.onFinishChanged,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: true,
        groupValue: task.isFinished,
        onChanged: (value) => onFinishChanged(value),
      ),
      onTap: onEdit,
      onLongPress: onDelete,
      title: Row(
        children: [
          (task.isImportant)
              ? Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              padding: EdgeInsets.all(4.0),
              color: Colors.black,
              child: Text(
                StringR.important,
                style: TextStyles.listTileChipTextStyle,
              ),
            ),
          )

          ///Chip Widgetでの実装
          // ? Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Chip(
          //       label: Text(StringR.important),),
          // )
              : Container(),
          Expanded(
            child: AutoSizeText(
              task.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: AutoSizeText(
        convertDateTimeToString(task.limitDateTime),
      ),
      trailing: PopupMenuButton(
          tooltip: StringR.showMenu,
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem<TaskListTileMenu>(
                child: Text(StringR.edit),
                value: TaskListTileMenu.EDIT,
              ),
              PopupMenuItem<TaskListTileMenu>(
                child: Text(StringR.delete),
                value: TaskListTileMenu.DELETE,
              ),
            ];
          },
          onSelected: (selectedMenu) {
            if (selectedMenu == TaskListTileMenu.EDIT) {
              onEdit();
            } else {
              onDelete();
            }

    },
      ),
    );
  }
}
