import 'package:enter_training_me/models/muscle_experience.dart';
import 'package:enter_training_me/widgets/analysis/user/exercised_muscle_radar_repartition_graph.dart';
import 'package:flutter/material.dart';

class MuscleProfileSection extends StatelessWidget {
  final List<MuscleExperience>? muscleExperiences;
  const MuscleProfileSection({Key? key, this.muscleExperiences})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (muscleExperiences == null || muscleExperiences!.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 32),
          child: Text("Muscle Profile",
              style: Theme.of(context).textTheme.headline4),
        ),
        ExercisedMuscleRadarRepartitionGraph(
            muscleExperiences: muscleExperiences!)
      ],
    );
  }
}
