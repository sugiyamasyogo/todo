import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/util/constants.dart';
import 'package:todo/view/style.dart';
import 'package:todo/view_model/view_model.dart';

showSnackBar({
  required BuildContext context,
  required String contentText,
  required bool isSnackBarActionNeeded,
  VoidCallback? onUndone,
}) {
  final viewModel = context.read<ViewModel>();
  final screenSize = viewModel.screenSize;

  if (screenSize == ScreenSize.SMALL) {
    final snackBar = SnackBar(
      content: Text(contentText),
      action: (isSnackBarActionNeeded || onUndone != null)
          ? SnackBarAction(
              label: StringR.undo,
              onPressed: onUndone!,
            )
          : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(contentText),
              Row(
                children: [
                  TextButton(
                    child: AutoSizeText(StringR.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  HorizontalSpacer.snackBar,
                  (isSnackBarActionNeeded || onUndone != null)
                      ? TextButton(
                          child: AutoSizeText(StringR.undo),
                          onPressed: () {
                            Navigator.pop(context);
                            onUndone!();
                          },
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
