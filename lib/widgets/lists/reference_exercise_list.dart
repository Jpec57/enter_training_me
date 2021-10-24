import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceExerciseList extends StatefulWidget {
  final bool withSearch;
  final VoidCallback onItemTap;
  const ReferenceExerciseList(
      {Key? key, this.withSearch = true, required this.onItemTap})
      : super(key: key);

  @override
  _ReferenceExerciseListState createState() => _ReferenceExerciseListState();
}

class _ReferenceExerciseListState extends State<ReferenceExerciseList> {
  late Future<List<ReferenceExercise>> _exoListFuture;
  late TextEditingController _exoSearchTextController;

  @override
  void initState() {
    super.initState();
    _exoSearchTextController = TextEditingController();
    setState(() {
      _exoListFuture =
          RepositoryProvider.of<ReferenceExerciseRepository>(context).getAll();
    });
  }

  @override
  void dispose() {
    _exoSearchTextController.dispose();
    super.dispose();
  }

  Widget _renderSearchBar() {
    return TextField(
      controller: _exoSearchTextController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _renderListTile(ReferenceExercise exo) {
//Expandable to see more info ? ?

    return InkWell(
      onTap: widget.onItemTap,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: CustomTheme.middleGreen))),
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "assets/exercises/pull_up.png",
                width: 70,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exo.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          exo.material.isEmpty
                              ? "None"
                              : exo.material.join(', '),
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white54)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:
                          Text(exo.description ?? "No description available."),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.withSearch ? _renderSearchBar() : Container(),
        Expanded(
          child: FutureBuilder(
            future: _exoListFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<ReferenceExercise>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _renderListTile(snapshot.data![index]);
                    });
              } else if (ConnectionState.waiting == snapshot.connectionState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(child: Text("An error occurred."));
            },
          ),
        ),
      ],
    );
  }
}
