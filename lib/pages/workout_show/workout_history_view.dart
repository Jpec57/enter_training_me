import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutHistoryView extends StatefulWidget {
  final Training referenceTraining;

  const WorkoutHistoryView({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutHistoryView> createState() => _WorkoutHistoryViewState();
}

class _WorkoutHistoryViewState extends State<WorkoutHistoryView> {
  late Future<List<Training>> _historyTrainings;

  @override
  void initState() {
    super.initState();
    _historyTrainings = RepositoryProvider.of<TrainingRepository>(context)
        .getByReference(widget.referenceTraining.id!);
  }

  @override
  Widget build(BuildContext context) {
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
            return Center(child: Text("No history"));
          }
          return Column(
            children: [
              Text("Test"),
              Expanded(
                child: ListView.builder(
                    itemCount: oldTrainings.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(oldTrainings[index].name),
                        children: [
                          Text("hello"),
                          Text("ca va"),
                        ],
                      );
                    }),
              ),
            ],
          );
        }

        return Text("Error");
      },
    );
  }
}
