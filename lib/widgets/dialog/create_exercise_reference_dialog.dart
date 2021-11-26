import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/eums/muscle_enum.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  bool _isOnlyIsometric = false;
  bool _isBodyweightExercise = false;
  List<String> _materials = [];
  List<String> _muscles = [];
  double _strainessFactor = 0.5;

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

  Widget _renderMuscleDropdown() {
    return MultiSelectChipField<String>(
      items: MuscleEnum.allMuscles.map((e) => MultiSelectItem(e, e)).toList(),
      icon: const Icon(Icons.check),
      onTap: (values) {
        _muscles = values;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomTheme.darkGrey,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Create a new exercise",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
                TextFormField(
                  controller: _exoNameController,
                ),
                _renderMuscleDropdown(),
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
      ),
    );
  }
}
