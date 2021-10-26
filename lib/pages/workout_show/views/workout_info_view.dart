part of '../workout_show_page.dart';

class WorkoutInfoView extends StatelessWidget {
  final Training referenceTraining;
  const WorkoutInfoView({Key? key, required this.referenceTraining})
      : super(key: key);

  Widget _renderMaterialList() {
    List<String> materials = referenceTraining.materials;
    if (materials.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: "Materials"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(referenceTraining.materials.join(", ")),
        ),
        const SectionDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderMaterialList(),
          referenceTraining.muscleRepartition.isEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionTitle(title: "Muscle Repartition"),
                    MuscleActivationRepartitionGraph(
                        muscleActivations: referenceTraining.muscleRepartition),
                  ],
                ),
          const SectionDivider(),
          const SectionTitle(title: "Training Type Repartition"),
          TrainingTypeRepartitionGraph(
            typeRepartition: referenceTraining.focusRepartition,
          ),
        ],
      ),
    );
  }
}
