part of '../workout_show_page.dart';

class WorkoutHistoryView extends StatefulWidget {
  final Training referenceTraining;

  const WorkoutHistoryView({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutHistoryView> createState() => _WorkoutHistoryViewState();
}

class _WorkoutHistoryViewState extends State<WorkoutHistoryView>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Training>> _historyTrainings;

  @override
  void initState() {
    super.initState();
    _historyTrainings = RepositoryProvider.of<TrainingRepository>(context)
        .getByReference(widget.referenceTraining.id!);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: _historyTrainings,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<Training> oldTrainings = snapshot.data;
          if (oldTrainings.isEmpty) {
            return const Center(child: Text("No history"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32.0),
                  child: Text(
                    "Workout Intensity Progression",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom :16.0),
                  child: TrainingHistoryEvolution(trainings: oldTrainings),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32.0),
                  child: Text(
                    "Workout Intensity Compare",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                WorkoutExerciseIntensityGraph(
                    realisedTraining: oldTrainings.last,
                    referenceTraining: oldTrainings.first,
                    barWidth: 10,
                    barsSpace: 2,
                    graphHeight: MediaQuery.of(context).size.height * 0.3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Compare with..."),
                      Text("20/09/21"),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: SectionDivider(),
                ),
                WorkoutTrainingSummaryContent(
                  realisedTraining: oldTrainings.last,
                  referenceTraining: oldTrainings.first,
                ),
              ],
            ),
          );
        }

        return Text("Error");
      },
    );
  }
}
