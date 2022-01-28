import 'package:flutter/material.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/common/show_add_new_task.dart';
import 'package:todo/view/style.dart';
import 'package:provider/provider.dart';
import 'package:todo/view_model/view_model.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColor.sideMenuBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                FlutterLogo(
                  size: 100.0,
                ),
                Text(
                  StringR.appTitle,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              StringR.addNewTask,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              final viewModel = context.read<ViewModel>();
              final screenSize = viewModel.screenSize;
              if (screenSize != ScreenSize.LARGE) Navigator.pop(context);
              _addNewTask(context);
            },
          ),
          SwitchListTile(
              title: Text(
                StringR.isFinishedTaskIncluded,
                style: TextStyle(color: Colors.white),
              ),
              //TODO
              value: false,
              //TODO
              onChanged: null),

          //パターン２
          ListTile(
            title: Text(StringR.showLicense),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: FlutterLogo(),
                applicationName: StringR.appTitle,
                applicationLegalese: "\u{a9} 2021 sugiyama terugo LLC",
                children: [
                  Text(
                    "他の情報やWidgetがだせる",
                  ),
                ],
              );
            },
          ),

          //パターン１
          // AboutListTile(
          //   icon: Icon(
          //     Icons.info_outline,
          //   ),
          //   applicationIcon: FlutterLogo(),
          //   applicationName: StringR.appTitle,
          //   applicationLegalese: "\u{a9} 2021 sugiyama terugo LLC",
          //   aboutBoxChildren: [
          //     Text(
          //       "他の情報やWidgetがだせる",
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  _addNewTask(BuildContext context) {
    showAddNewTask(context);
  }
}
