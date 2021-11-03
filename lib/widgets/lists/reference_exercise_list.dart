import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
import 'package:enter_training_me/widgets/lists/reference_exercise_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnExerciseChosen = void Function(ReferenceExercise exercise);

class ReferenceExerciseList extends StatefulWidget {
  final bool withSearch;
  final OnExerciseChosen onExerciseChosen;
  final List<ReferenceExercise> preloadedExos;
  const ReferenceExerciseList(
      {Key? key,
      this.withSearch = true,
      required this.onExerciseChosen,
      this.preloadedExos = const []})
      : super(key: key);

  @override
  _ReferenceExerciseListState createState() => _ReferenceExerciseListState();
}

class _ReferenceExerciseListState extends State<ReferenceExerciseList> {
  late Future<List<ReferenceExercise>> _exoListFuture;

  late TextEditingController _exoSearchTextController;

  Future<List<ReferenceExercise>> loadReferenceExercises() async {
    if (widget.preloadedExos.isNotEmpty) {
      return widget.preloadedExos;
    }
    return await RepositoryProvider.of<ReferenceExerciseRepository>(context)
        .getAll();
  }

  @override
  void initState() {
    super.initState();
    _exoSearchTextController = TextEditingController();
    _exoSearchTextController.addListener(() {
      setState(() {});
    });
    setState(() {
      _exoListFuture = loadReferenceExercises();
    });
  }

  @override
  void dispose() {
    _exoSearchTextController.removeListener(() {});
    _exoSearchTextController.dispose();
    super.dispose();
  }

  Widget _renderSearchBar() {
    return TextField(
      controller: _exoSearchTextController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: const Icon(Icons.search)),
      ),
    );
  }

  List<ReferenceExercise> filterBySearch(List<ReferenceExercise> list) {
    String searchText = _exoSearchTextController.text;
    if (searchText.isEmpty) {
      return list;
    }
    return list.where((element) {
      return element.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
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
                List<ReferenceExercise> filteredExos =
                    filterBySearch(snapshot.data!);
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredExos.length,
                    itemBuilder: (context, index) {
                      return ReferenceExerciseListTile(
                        exo: filteredExos[index],
                        onExerciseChosen: (ReferenceExercise exercise) {
                          widget.onExerciseChosen(exercise);
                        },
                      );
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
