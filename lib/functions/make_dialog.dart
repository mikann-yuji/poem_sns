import 'package:flutter/material.dart';

void makeDialog(BuildContext context, String title, String content, String cancelWord, String okWord, void Function() callback) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(cancelWord),
              onPressed: () => Navigator.of(context).pop(0),
            ),
            TextButton(
              child: Text(okWord),
              onPressed: callback,
            ),
          ]);
    });
}
