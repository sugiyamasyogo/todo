import 'package:flutter/material.dart';
import 'package:todo/view/detail/detail_page.dart';
import 'package:todo/view/side_menu/side_menu_page.dart';
import 'package:todo/view/style.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/task_list/task_list_page.dart';
import 'package:todo/view_model/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth >= BreakPointWidth.midToLarge) {
          viewModel.screenSize = ScreenSize.LARGE;
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: SideMenuPage(),
              ),
              Expanded(
                flex: 4,
                child: TaskListPage(),
              ),
              Expanded(
                flex: 6,
                child: DetailPage(),
              ),
            ],
          );
        } else if (constrains.maxWidth >= BreakPointWidth.smallToMid) {
          viewModel.screenSize = ScreenSize.MID;
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: TaskListPage(),
              ),
              Expanded(
                flex: 2,
                child: DetailPage(),
              ),
            ],
          );
        } else {
          viewModel.screenSize = ScreenSize.SMALL;
          return TaskListPage();
        }
      },
    );
  }
}
