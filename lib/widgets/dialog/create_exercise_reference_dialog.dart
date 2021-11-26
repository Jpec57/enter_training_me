import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

typedef ReferenceExerciseCallback = void Function(ReferenceExercise?);

class CreateExerciseReferenceDialog extends StatefulWidget {
  final ReferenceExerciseCallback callback;
  const CreateExerciseReferenceDialog({Key? key, required this.callback})
      : super(key: key);

  @override
  State<CreateExerciseReferenceDialog> createState() =>
      _CreateExerciseReferenceDialogState();
}

class _CreateExerciseReferenceDialogState
    extends State<CreateExerciseReferenceDialog> {
  late TextEditingController _exoNameController;

  @override
  void initState() {
    super.initState();
    _exoNameController = TextEditingController();
  }

  @override
  void dispose() {
    _exoNameController.dispose();
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
              Text("TOTO",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.greenGrey,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        // widget.callback();
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
