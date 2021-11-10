import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/analysis/history/exercise_history_evolution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseProgressionSection extends StatefulWidget {
  const ExerciseProgressionSection({Key? key}) : super(key: key);

  @override
  _ExerciseProgressionSectionState createState() =>
      _ExerciseProgressionSectionState();
}

class _ExerciseProgressionSectionState
    extends State<ExerciseProgressionSection> {
  late Future<List<ReferenceExercise>>? _realisedExoReferencesFuture;

  @override
  void initState() {
    super.initState();
    _realisedExoReferencesFuture =
        RepositoryProvider.of<UserRepository>(context)
            .getRealisedExoForViewer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 32, bottom: 16),
          child: Text(
            "Exercise Estimated 1RM Progression",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        FutureBuilder(
          future: _realisedExoReferencesFuture,
          builder: (BuildContext context,
              AsyncSnapshot<List<ReferenceExercise>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data!.isNotEmpty) {
              List<ReferenceExercise> exos = snapshot.data!;
              return ExerciseHistoryEvolution(
                referenceExercises: exos,
              );
            }
            return const Center(
              child: Text("No data"),
            );
          },
        ),
      ],
    );
  }
}
