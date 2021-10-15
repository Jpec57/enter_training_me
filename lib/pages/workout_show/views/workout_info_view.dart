part of '../workout_show_page.dart';

class WorkoutInfoView extends StatelessWidget {
  final Training referenceTraining;
  const WorkoutInfoView({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              spacing: 24,
              children: [
                referenceTraining.estimatedTimeInSeconds != null
                    ? WorkoutMetric(
                        metric:
                            "${referenceTraining.estimatedTimeInSeconds! ~/ 60}",
                        unit: " min")
                    : Container(),
                Text("EXPERT", style: GoogleFonts.bebasNeue(fontSize: 25)),
              ],
            ),
          ),
          const SectionDivider(),
          const SectionTitle(title: "Muscle Repartition"),
          const MuscleActivationRepartitionGraph(),
          const SectionDivider(),
          const SectionTitle(title: "Training Type Repartition"),
          const TrainingTypeRepartitionGraph(),
        ],
      ),
    );
  }
}
