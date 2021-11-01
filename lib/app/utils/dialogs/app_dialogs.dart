import 'package:flutter/material.dart';

class AppDialogs {
  static void showDeleteDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function() onPositive,
      required Function() onNegative}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: onNegative,
                child: Text('CANCEL'),
              ),
              TextButton(
                onPressed: onPositive,
                child: Text('DELETE'),
              ),
            ],
          );
        });
  }
}
