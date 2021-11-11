import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

typedef ValueCallbackMethod<T> = Future<void> Function(T strValue);

class ReturnDialog<T> extends StatefulWidget {
  final String title;
  final ValueCallbackMethod<T> callback;
  final T? currentValue;
  final bool showQuickIntIncrease;
  const ReturnDialog(
      {Key? key,
      required this.title,
      this.currentValue,
      this.showQuickIntIncrease = true,
      required this.callback})
      : super(key: key);

  @override
  State<ReturnDialog> createState() => _ReturnDialogState();
}

class _ReturnDialogState extends State<ReturnDialog> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController =
        TextEditingController(text: widget.currentValue?.toString() ?? "");
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomTheme.darkGrey,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4),
              TextField(
                  controller: _textController,
                  minLines: 4,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.callback(_textController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Validate")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
