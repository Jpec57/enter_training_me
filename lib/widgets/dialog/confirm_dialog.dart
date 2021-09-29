
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function confirmCallback;

  const ConfirmDialog({Key? key, required this.message, required this.confirmCallback, this.title = "Confirm"}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Confirm"),
          onPressed: () {
            confirmCallback();
          },
        ),
      ],
    );
  }
}