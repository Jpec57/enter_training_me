import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String str);

class RenameTrainingDialog extends StatefulWidget {
  final String? initialValue;
  final StringCallback callback;
  const RenameTrainingDialog(
      {Key? key, required this.callback, this.initialValue})
      : super(key: key);

  @override
  _RenameTrainingDialogState createState() => _RenameTrainingDialogState();
}

class _RenameTrainingDialogState extends State<RenameTrainingDialog> {
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void changeTrainingName() async {}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomTheme.darkGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Rename training",
                style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white)),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.callback(_nameController.text);
                  Navigator.of(context).pop();
                },
                child: const Text("Rename"))
          ],
        ),
      ),
    );
  }
}
