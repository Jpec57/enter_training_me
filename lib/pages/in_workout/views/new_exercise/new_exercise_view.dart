part of '../../in_workout_page.dart';

class NewExerciseView extends StatefulWidget {
  final TabController tabController;

  const NewExerciseView({Key? key, required this.tabController})
      : super(key: key);

  @override
  _NewExerciseViewState createState() => _NewExerciseViewState();
}

class _NewExerciseViewState extends State<NewExerciseView> {
  ReferenceExercise? _selectedRefExo;
  int _restBtwSet = 120;
  double _weight = 0;
  final ExerciseSet _defaultSet = const ExerciseSet(reps: 5, weight: 100);
  final List<ExerciseSet> _setList = [const ExerciseSet(reps: 5, weight: 100)];
  late TextEditingController _weightTextController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _weightTextController = TextEditingController();
    _weightTextController.addListener(() {
      if (_weightTextController.text.isNotEmpty) {
        _weight = double.parse(_weightTextController.text);
      } else {
        _weight = 0;
      }
    });
  }

  @override
  void dispose() {
    _weightTextController.removeListener(() {});
    _weightTextController.dispose();
    super.dispose();
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
        print("value $value");
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
              child: Text("Reps ${set.reps}"),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                showWeightModal(context, index);
              },
              child: Text("Weight ${set.weight}"),
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
            const Expanded(
              child:
                  Text("REPS", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Expanded(
              child:
                  Text("WEIGHT", style: TextStyle(fontWeight: FontWeight.bold)),
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
                  BlocBuilder<InWorkoutBloc, InWorkoutState>(
                    buildWhen: (prev, next) =>
                        prev.realisedTraining.exercisesAsFlatList.length !=
                        next.realisedTraining.exercisesAsFlatList.length,
                    builder: (context, state) {
                      return IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          if (state
                              .realisedTraining.exercisesAsFlatList.isEmpty) {
                            BlocProvider.of<InWorkoutBloc>(context).add(
                                ChangedViewEvent(widget.tabController,
                                    InWorkoutView.endWorkoutView));
                          } else {
                            BlocProvider.of<InWorkoutBloc>(context).add(
                                ChangedViewEvent(widget.tabController,
                                    InWorkoutView.inRestView));
                          }
                        },
                      );
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "New exo",
                    style: Theme.of(context).textTheme.headline4,
                  )))
                ],
              ),
              InkWell(
                onTap: () {
                  Get.dialog(ChooseExerciseDialog(
                    onExerciseChosen: (ReferenceExercise exo) {
                      setState(() {
                        _selectedRefExo = exo;
                      });
                      Navigator.of(context).pop();
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
                        RealisedExercise? _toAddExercise = RealisedExercise(
                            exerciseReference: _selectedRefExo!,
                            sets: _setList,
                            restBetweenSet: _restBtwSet);
                        BlocProvider.of<InWorkoutBloc>(context).add(
                            AddedExoEvent(
                                widget.tabController, _toAddExercise));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Add this exercise".toUpperCase()),
                      ))
            ],
          ),
        )),
      ),
    );
  }
}
