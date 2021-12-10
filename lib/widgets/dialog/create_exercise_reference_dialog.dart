import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/enums/muscle_enum.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_lib;
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isOnlyIsometric = false;
  bool _isBodyweightExercise = false;
  List<String> _materials = [];
  List<String> _muscles = [];
  double _strainessFactor = 0.5;
  String? formError;

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
      items: MuscleEnum.allMuscles
          .map((e) => MultiSelectItem<String>(e.toUpperCase(), e))
          .toList(),
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
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Create a new exercise",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
                formError != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text("Error: $formError",
                            style: const TextStyle(color: Colors.red)),
                      )
                    : Container(),
                TextFormField(
                  controller: _exoNameController,
                  validator: (str) {
                    if (str != null && str.length > 2) {
                      return null;
                    }
                    return "The name must be at least 3 character-long";
                  },
                ),
                // _renderMuscleDropdown(),
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
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            ReferenceExercise refExo = ReferenceExercise(
                                name: _exoNameController.text);
                            try {
                              ReferenceExercise createdRef =
                                  await RepositoryProvider.of<
                                          ReferenceExerciseRepository>(context)
                                      .post(refExo.toJson());
                              widget.callback(createdRef);
                              Navigator.of(context).pop();
                            } on Exception catch (e) {
                              get_lib.Get.snackbar("Error", e.toString());
                            }
                          }
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
