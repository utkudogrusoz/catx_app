import 'package:flutter/material.dart';

SnackBar customShowDialog({@required String? content, @required Color? backgroundColor}) {
  return SnackBar(
    content: Text(content!),
    elevation: 8,
    backgroundColor: backgroundColor,
  );
}
