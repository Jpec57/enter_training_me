import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/services/repositories/execution_style_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef StringMethod = void Function(String strValue);

class ChangeExerciseStyleDialog<T> extends StatefulWidget {
  const ChangeExerciseStyleDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeExerciseStyleDialog> createState() =>
      _ChangeExerciseStyleDialogState();
}

class _ChangeExerciseStyleDialogState extends State<ChangeExerciseStyleDialog> {
  late Future<List<ExecutionStyle>> _loadExerciseStyleFuture;
  @override
  void initState() {
    super.initState();
    _loadExerciseStyleFuture =
        RepositoryProvider.of<ExecutionStyleRepository>(context).getAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      height: MediaQuery.of(context).size.height * 0.6,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: CustomTheme.middleGreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select an exercise execution style",
                      style: Theme.of(context).textTheme.headline4),
                )),
            FutureBuilder(
              future: _loadExerciseStyleFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ExecutionStyle>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<ExecutionStyle> executionStyles = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: executionStyles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              executionStyles[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(executionStyles[index].description ??
                                "No description available."),
                          );
                        }),
                  );
                }
                return const Center(child: Text("Error"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
