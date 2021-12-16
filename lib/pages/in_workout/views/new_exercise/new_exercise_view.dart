import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/choose_exercise_dialog.dart';
import 'package:enter_training_me/widgets/dialog/change_exercise_set_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnRealisedExerciseCallback = void Function(RealisedExercise exercise);

class NewExerciseView extends StatefulWidget {
  final VoidCallback onDismiss;
  final RealisedExercise? editedExercise;
  final OnRealisedExerciseCallback onExerciseChosen;

  const NewExerciseView(
      {Key? key,
      required this.onExerciseChosen,
      required this.onDismiss,
      this.editedExercise})
      : super(key: key);

  @override
  _NewExerciseViewState createState() => _NewExerciseViewState();
}

class _NewExerciseViewState extends State<NewExerciseView> {
  ReferenceExercise? _selectedRefExo;
  int _restBtwSet = 180;
  bool isIsometric = false;

  late ExerciseSet _defaultSet;
  late List<ExerciseSet> _setList;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _defaultSet = const ExerciseSet(reps: 5, weight: 100);
    _selectedRefExo = widget.editedExercise?.exerciseReference;
    _setList = widget.editedExercise?.sets ?? [];
  }

  Widget _renderRestChoiceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              if (_restBtwSet > 10) {
                setState(() {
                  _restBtwSet = _restBtwSet - 10;
                });
              }
            },
            icon: const Icon(Icons.remove_circle, color: Colors.white)),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("How much rest between set ?",
                style: Theme.of(context).textTheme.headline4),
          ),
          Text("${_restBtwSet}s", style: Theme.of(context).textTheme.headline4)
        ]),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _restBtwSet = _restBtwSet + 10;
              });
            },
            icon: const Icon(Icons.add_circle, color: Colors.white)),
      ],
    );
  }

  Widget _renderSelectedExoWidget(ReferenceExercise exo) {
    return Center(
        child: Text(exo.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)));
  }

  void showRepsModal(BuildContext context, int setIndex) {
    Get.dialog(ChangeExerciseSetDialog<int>(
      currentValue: _setList[setIndex].reps,
      title: "How many reps do you intent to do ?",
      setForOneCallback: (value) {
        int parseValue = int.parse(value);
        setState(() {
          _setList[setIndex] = _setList[setIndex].copyWith(reps: parseValue);
        });
      },
    ));
  }

  void showWeightModal(BuildContext context, int setIndex) {
    Get.dialog(ChangeExerciseSetDialog<double>(
      title: "How heavy do you intent to lift ?",
      currentValue: _setList[setIndex].weight,
      showQuickIntIncrease: false,
      setForOneCallback: (String value) {
        int parsedValue = int.parse(value.substring(0, value.indexOf('.')));
        setState(() {
          _setList[setIndex] =
              _setList[setIndex].copyWith(weight: parsedValue.toDouble());
        });
      },
    ));
  }

  Widget _renderExoSetWidget(ExerciseSet set, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(child: Text("${index + 1}")),
          Expanded(
            child: InkWell(
              onTap: () {
                showRepsModal(context, index);
              },
              child: Text("${set.reps} ${isIsometric ? "sec" : "reps"}"),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                showWeightModal(context, index);
              },
              child: Text("${set.weight}kgs"),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (_setList.length > 1) {
                  setState(() {
                    _setList.removeAt(index);
                  });
                }
              },
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderSetColumn() {
    List<Widget> setChildren = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Text(isIsometric ? "DURATION" : "REPS",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Expanded(
              child:
                  Text("WEIGHT", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Expanded(
              child: Text("ACTIONS",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      )
    ];
    for (int i = 0; i < _setList.length; i++) {
      setChildren.add(_renderExoSetWidget(_setList[i], i));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: setChildren,
    );
  }

  void addSet() {
    ExerciseSet? lastSet =
        _setList.isNotEmpty ? _setList[_setList.length - 1] : null;
    setState(() {
      _setList.add(lastSet ?? _defaultSet);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: CustomTheme.darkGrey,
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: widget.onDismiss,
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    widget.editedExercise != null ? "Edit exo" : "New exo",
                    style: Theme.of(context).textTheme.headline4,
                  )))
                ],
              ),
              InkWell(
                onTap: () {
                  Get.dialog(ChooseExerciseDialog(
                    onExerciseChosen: (ReferenceExercise exo) {
                      if (exo.isOnlyIsometric) {
                        isIsometric = true;
                        // for (var set in _setList) {
                        //   set.copyWith(weight: 0);
                        // }
                      }
                      setState(() {
                        _selectedRefExo = exo;
                      });
                    },
                  ));
                },
                child: Container(
                    decoration: const BoxDecoration(color: Colors.amber),
                    height: 100,
                    width: size.width,
                    child: _selectedRefExo == null
                        ? Center(
                            child: Text("Select an exo".toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )))
                        : _renderSelectedExoWidget(_selectedRefExo!)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Is Isometric ?",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SwitchListTile(
                                title: Text(isIsometric ? "Yes" : "No",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                value: isIsometric,
                                onChanged: (value) {
                                  setState(() {
                                    isIsometric = value;
                                  });
                                }),
                            Text(
                              "Sets",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            _renderSetColumn(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                  onPressed: addSet,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add_circle,
                                          color: Colors.white),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: _renderRestChoiceRow(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (_selectedRefExo == null)
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        if (_setList.isEmpty) {
                          Get.snackbar('error'.tr, "empty_set_error".tr);
                          return;
                        }
                        RealisedExercise? _toAddExercise = RealisedExercise(
                            exerciseReference: _selectedRefExo!,
                            sets: _setList,
                            isIsometric: isIsometric,
                            restBetweenSet: _restBtwSet);

                        widget.onExerciseChosen(_toAddExercise);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text((widget.editedExercise != null
                                ? "Edit this exercise"
                                : "Add this exercise")
                            .toUpperCase()),
                      ))
            ],
          ),
        )),
      ),
    );
  }
}
