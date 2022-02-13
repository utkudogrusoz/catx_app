import 'package:catx_app/utilities/ui/widgets/show_dialog/custom_show_dialog.dart';
import 'package:flutter/material.dart';

void showCustomDialog({@required BuildContext? context, @required String? content, @required Color? backgroundColor}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    customShowDialog(
      content: content!,
      backgroundColor: backgroundColor,
    ),
  );
}
