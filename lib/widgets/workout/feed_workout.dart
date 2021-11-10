import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page_arguments.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:enter_training_me/widgets/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class FeedWorkout extends StatelessWidget {
  final Training referenceTraining;
  final VoidCallback? onTrainingRemove;
  final bool otherColor;
  const FeedWorkout(
      {Key? key,
      required this.referenceTraining,
      this.otherColor = false,
      this.onTrainingRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onLongPress: () {
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
    }, onTap: () {
      Get.toNamed(WorkoutShowPage.routeName,
          arguments:
              WorkoutShowPageArguments(referenceTraining: referenceTraining));
    }, child: Builder(builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: CustomTheme.middleGreen,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserAvatar(user: referenceTraining.author, radius: 18),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            referenceTraining.name,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(referenceTraining.author?.username ??
                                "Creator"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    color: CustomTheme.grey,
                    child: Image.asset("assets/exercises/pull_up.png"))),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: CustomTheme.middleGreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  referenceTraining.createdAt != null
                      ? Text(
                          referenceTraining.formattedCreationDate!,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.favorite))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
  }
}
