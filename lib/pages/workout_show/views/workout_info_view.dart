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
