import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
import 'package:enter_training_me/widgets/dialog/create_exercise_reference_dialog.dart';
import 'package:enter_training_me/widgets/lists/reference_exercise_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_lib;

typedef OnExerciseChosen = void Function(ReferenceExercise exercise);

class ReferenceExerciseList extends StatefulWidget {
  final bool withSearch;
  final bool withCreateNewOption;
  final OnExerciseChosen onExerciseChosen;
  final List<ReferenceExercise> preloadedExos;
  const ReferenceExerciseList(
      {Key? key,
      this.withSearch = true,
      this.withCreateNewOption = true,
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
                    itemCount: filteredExos.length +
                        (widget.withCreateNewOption ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (widget.withCreateNewOption && index == 0) {
                        return InkWell(
                          onTap: () {
                            get_lib.Get.dialog(CreateExerciseReferenceDialog(
                              callback: (ReferenceExercise? refExo) {
                                print(refExo);
                              },
                            ));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      width: 1,
                                      color: CustomTheme.middleGreen)),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add_circle_outline,
                                      size: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text("Create new",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      int realIndex =
                          widget.withCreateNewOption ? index - 1 : index;
                      return ReferenceExerciseListTile(
                        exo: filteredExos[realIndex],
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
