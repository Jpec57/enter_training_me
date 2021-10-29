part of 'workout_end_view.dart';

class EndWorkoutAnalysis extends StatelessWidget {
  final Training realisedTraining;
  final Training? referenceTraining;
  const EndWorkoutAnalysis(
      {Key? key, required this.realisedTraining, this.referenceTraining})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: WorkoutTrainingSummaryContent(
              realisedTraining: realisedTraining,
              referenceTraining: referenceTraining),
        ),
        const SectionDivider(),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16.0),
          child: Text(
            "Workout Estimated 1RM Summary",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        WorkoutExerciseIntensityGraph(
            realisedTraining: realisedTraining,
            referenceTraining: referenceTraining,
            barWidth: 10,
            barsSpace: 2,
            graphHeight: MediaQuery.of(context).size.height * 0.3),
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: SectionDivider(),
        ),
      ],
    );
  }
}
