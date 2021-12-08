import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TrainingContainer extends StatelessWidget {
  final Training referenceTraining;
  final VoidCallback? onTrainingRemove;
  final bool isClickDisabled;
  final bool otherColor;
  const TrainingContainer(
      {Key? key,
      required this.referenceTraining,
      this.otherColor = false,
      this.isClickDisabled = false,
      this.onTrainingRemove})
      : super(key: key);

  void _onLongPress(BuildContext context) {
    Get.dialog(ConfirmDialog(
      message: "Would you like to delete this training ?",
      confirmCallback: () async {
        bool isSuccess =
            await RepositoryProvider.of<TrainingRepository>(context)
                .delete(referenceTraining.id!);
        Navigator.of(context).pop();

        if (isSuccess) {
          Get.snackbar("Success", "This workout has been deleted");
          if (onTrainingRemove != null) {
            onTrainingRemove!();
          }
        } else {
          Get.snackbar("Error", "An error occurred");
        }
      },
      confirmLabel: "Delete",
    ));
  }

  void _onTap(BuildContext context) {
    Navigator.restorablePushNamed(context, WorkoutShowPage.routeName,
        arguments: {"trainingId": referenceTraining.id});
    // Get.toNamed(WorkoutShowPage.routeName,
    //     arguments:
    //         WorkoutShowPageArguments(referenceTraining: referenceTraining));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () => _onLongPress(context),
        onTap: isClickDisabled ? null : () => _onTap(context),
        child: Builder(builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  decoration: BoxDecoration(
                      color: otherColor
                          ? CustomTheme.grey
                          : CustomTheme.middleGreen,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Positioned.fill(
                    child: Image.asset("assets/exercises/pull_up.png")),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: CustomTheme.greenSwatch.shade700),
                      child: Center(
                        child: Text(
                          referenceTraining.name,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ],
            ),
          );
        }));
  }
}
