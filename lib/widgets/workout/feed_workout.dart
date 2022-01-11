import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:enter_training_me/widgets/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
      showDialog(
          context: context,
          builder: (dialogContext) => ConfirmDialog(
                message: "Would you like to delete this training ?",
                confirmCallback: () async {
                  bool isSuccess =
                      await RepositoryProvider.of<TrainingRepository>(context)
                          .delete(referenceTraining.id!);
                  Navigator.of(dialogContext).pop();

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
    }, child: Builder(builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: CustomTheme.middleGreen,
                  border: Border.all(
                      width: 1, color: CustomTheme.darkGrey.withOpacity(0.8)),
                  borderRadius: const BorderRadius.only(
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              referenceTraining.name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                                referenceTraining.author?.username ?? "Creator",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.go(WorkoutShowPage.routeName
                      .replaceFirst(':id', referenceTraining.id.toString()));
                },
                child: Container(
                    color: CustomTheme.grey,
                    child: Image.asset("assets/exercises/pull_up.png")),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add)),
                      IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                          icon: const Icon(Icons.favorite))
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
