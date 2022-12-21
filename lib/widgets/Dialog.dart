import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, String title, String desc) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      btnOkColor: Colors.blue,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {})
    ..show();
}

void showErrorDialog(BuildContext context, String title, String desc) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
    ..show();
}
