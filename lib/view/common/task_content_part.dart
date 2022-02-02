import 'package:flutter/material.dart';
import 'package:todo/data/task.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/util/functions.dart';
import 'package:todo/view/style.dart';

class TaskContentPart extends StatefulWidget {
  final Task? selectedTask;
  final bool isEditMode;

  const TaskContentPart({
    Key? key,
    this.selectedTask,
    required this.isEditMode,
  }) : super(key: key);

  @override
  State<TaskContentPart> createState() => TaskContentPartState();
}

class TaskContentPartState extends State<TaskContentPart> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  bool isImportant = false;
  DateTime limitDataTime = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isEditMode && widget.selectedTask != null) {
      setDetailData();
    }
    super.initState();
  }

  void setDetailData() {
    final task = widget.selectedTask!;
    titleController.text = task.title;
    detailController.text = task.detail;
    isImportant = task.isImportant;
    limitDataTime = task.limitDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringR.pleaseEnterTitle;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                autofocus: true,
                maxLines: 1,
                controller: titleController,
                style: TextStyles.newTaskTitleTextStyle,
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  hintText: StringR.title,
                  border: OutlineInputBorder(),
                ),
              ),
              VerticalSpacer.taskContent,
              Row(
                children: [
                  HorizontalSpacer.taskContent,
                  Checkbox(
                      value: isImportant,
                      onChanged: (value) {
                        setState(() {
                          isImportant = value!;
                        });
                      }),
                  Text(
                    StringR.important,
                    style: TextStyles.newTaskItemTextStyle,
                  )
                ],
              ),
              VerticalSpacer.taskContent,
              Row(
                children: [
                  HorizontalSpacer.taskContent,
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _setLimitData(),
                  ),
                  Text(
                    convertDateTimeToString(limitDataTime),
                    style: TextStyles.newTaskItemTextStyle,
                  ),
                  HorizontalSpacer.taskContent,
                  (DateTime.now().compareTo(limitDataTime) > 0)
                      ? Chip(
                          label: Text(StringR.timeOver),
                          backgroundColor: WidgetColors.timeOverChipBgColor,
                        )
                      : Container(),
                ],
              ),
              VerticalSpacer.taskContent,
              TextField(
                maxLines: 10,
                controller: detailController,
                style: TextStyles.newTaskDetailTextStyle,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: StringR.detail,
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setLimitData() async {
    limitDataTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 36500)),
          locale: Locale("ja"),
        ) ??
        DateTime.now();
    setState(() {});
  }


}
