import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

typedef ValueCallbackMethod<T> = Future<void> Function(T strValue);

class ReturnDialog<T> extends StatefulWidget {
  final String title;
  final String? description;
  final ValueCallbackMethod<String> callback;
  final int minLines;
  final T? currentValue;
  final bool showQuickIntIncrease;
  const ReturnDialog(
      {Key? key,
      required this.title,
      this.currentValue,
      this.minLines = 1,
      this.description,
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
              widget.description != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(widget.description!),
                    )
                  : Container(),
              TextField(
                  controller: _textController,
                  minLines: widget.minLines,
                  maxLines: widget.minLines == 1 ? 1 : widget.minLines + 1,
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
