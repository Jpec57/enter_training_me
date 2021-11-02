import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutShowDescription extends StatefulWidget {
  final bool isEditting;
  final Training referenceTraining;
  const WorkoutShowDescription(
      {Key? key, required this.referenceTraining, this.isEditting = false})
      : super(key: key);

  @override
  State<WorkoutShowDescription> createState() => _WorkoutShowDescriptionState();
}

class _WorkoutShowDescriptionState extends State<WorkoutShowDescription> {
  Widget _renderEdittingTools(
      int totalExoCount, int currentIndex, bool isEditting) {
    if (!isEditting) {
      return Container();
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentIndex > 0
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward, color: Colors.white))
              : const Icon(Icons.arrow_upward, color: Colors.transparent),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_downward, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _renderDeleteTrainingButton(bool isEditting) {
    if (widget.referenceTraining.id == null || !isEditting) {
      return Container();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: CustomTheme.greenGrey,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            bool isSuccess = await RepositoryProvider.of<TrainingRepository>(
                    context)
                .removeFromSavedTrainingAction(widget.referenceTraining.id!);
            if (isSuccess) {
              Get.offNamedUntil(HomePage.routeName, (route) => false);
            }
          },
          child: const Text("REMOVE FROM SAVED")),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            bool isSuccess =
                await RepositoryProvider.of<TrainingRepository>(context)
                    .delete(widget.referenceTraining.id!);
            if (isSuccess) {
              Get.offNamedUntil(HomePage.routeName, (route) => false);
            }
          },
          child: const Text("DELETE",
              style: TextStyle(fontWeight: FontWeight.bold))),
      const SectionDivider(),
    ]);
  }

  Widget _renderExoCard(RealisedExercise exo, bool isEditting, int currentIndex,
      int totalExoCount) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: CustomTheme.grey,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/exercises/pull_up.png",
                  // height: 70,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: CustomTheme.middleGreen,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: isEditting ? () {} : null,
                            child: Text(exo.exerciseReference.name,
                                style: Theme.of(context).textTheme.headline4),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          onTap: isEditting ? () {} : null,
                          child: Text(
                              "=> " + (exo.executionStyle?.name ?? "Regular")),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: isEditting ? () {} : null,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: exo.sets
                                      .map((set) => Text(set.str))
                                      .toList()),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: InkWell(
                              onTap: isEditting ? () {} : null,
                              child: Text(
                                  "${Utils.convertToDuration(exo.restBetweenSet)}/set"),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _renderEdittingTools(totalExoCount, currentIndex, isEditting)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<RealisedExercise> exos = widget.referenceTraining.exercisesAsFlatList;
    List<Widget> exoWidgets = [];
    int exoLength = exos.length;
    for (var i = 0; i < exoLength; i++) {
      exoWidgets.add(_renderExoCard(exos[i], widget.isEditting, i, exoLength));
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderDeleteTrainingButton(widget.isEditting),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Wrap(
              spacing: 24,
              children: [
                widget.referenceTraining.estimatedTimeInSeconds != null
                    ? WorkoutMetric(
                        metric:
                            "${widget.referenceTraining.estimatedTimeInSeconds! ~/ 60}",
                        unit: " min")
                    : Container(),
                Text("EXPERT", style: GoogleFonts.bebasNeue(fontSize: 25)),
              ],
            ),
          ),

          const SectionDivider(),

          ...exoWidgets,
          // WorkoutTrainingContent(referenceTraining: widget.referenceTraining),
        ],
      ),
    );
  }
}
