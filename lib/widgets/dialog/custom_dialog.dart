import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomDialog<T> extends StatefulWidget {
  final String title;
  final T? currentValue;
  const CustomDialog({Key? key, required this.title, this.currentValue})
      : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
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
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_textController.text);
                  },
                  child: Text("Confirm"))
            ],
          ),
        ),
      ),
    );
  }
}
