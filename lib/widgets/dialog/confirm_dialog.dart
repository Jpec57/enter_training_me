import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String confirmLabel;
  final String cancelLabel;
  final String title;
  final String message;
  final VoidCallback confirmCallback;
  final VoidCallback? cancelCallback;

  const ConfirmDialog(
      {Key? key,
      required this.message,
      required this.confirmCallback,
      this.cancelCallback,
      this.confirmLabel = "Confirm",
      this.cancelLabel = "Cancel",
      this.title = "Confirm"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(cancelLabel),
          onPressed: () {
            cancelCallback != null
                ? cancelCallback!()
                : Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(confirmLabel),
          onPressed: () {
            confirmCallback();
          },
        ),
      ],
    );
  }
}
