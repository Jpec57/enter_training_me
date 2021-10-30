import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

typedef StringMethod = void Function(String strValue);

class ChangeExerciseSetDialog<T> extends StatefulWidget {
  final String title;
  final StringMethod? setForAllCallback;
  final StringMethod setForOneCallback;
  final T? currentValue;
  const ChangeExerciseSetDialog(
      {Key? key,
      required this.title,
      this.currentValue,
      this.setForAllCallback,
      required this.setForOneCallback})
      : super(key: key);

  @override
  State<ChangeExerciseSetDialog> createState() =>
      _ChangeExerciseSetDialogState();
}

class _ChangeExerciseSetDialogState extends State<ChangeExerciseSetDialog> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.setForAllCallback != null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: CustomTheme.greenGrey,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            widget.setForAllCallback!(_textController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text("Set for all sets"))
                      : Container(),
                  ElevatedButton(
                      onPressed: () {
                        widget.setForOneCallback(_textController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text("Set for this set")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
