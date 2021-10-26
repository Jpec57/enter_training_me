import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutShowDescription extends StatefulWidget {
  final Training referenceTraining;
  const WorkoutShowDescription({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutShowDescription> createState() => _WorkoutShowDescriptionState();
}

class _WorkoutShowDescriptionState extends State<WorkoutShowDescription> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          WorkoutTrainingContent(referenceTraining: widget.referenceTraining),
        ],
      ),
    );
  }
}
