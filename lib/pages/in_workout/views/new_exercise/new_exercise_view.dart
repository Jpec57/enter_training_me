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
  int _nbSets = 2;
  int _nbReps = 5;
  double _weight = 0;
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

  Widget _renderWeightChoiceRow() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text("How much weight ?",
            style: Theme.of(context).textTheme.headline4),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            width: 150,
            child: TextField(
                controller: _weightTextController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    filled: true, fillColor: Colors.white)),
          ),
        ],
      ),
      // Text(
      //     ((_selectedRefExo?.isBodyweightExercise ?? false) && _weight == 0)
      //         ? "BW"
      //         : "${_weight}kgs",
      //     style: Theme.of(context).textTheme.headline4)
    ]);
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

  Widget _renderRepsChoiceRow() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text("How many reps ?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                if (_nbSets > 0) {
                  setState(() {
                    _nbReps = _nbReps - 1;
                  });
                }
              },
              icon: const Icon(Icons.remove_circle, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:
                Text("$_nbReps", style: Theme.of(context).textTheme.headline4),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                setState(() {
                  _nbReps = _nbReps + 1;
                });
              },
              icon: const Icon(Icons.add_circle, color: Colors.white)),
        ],
      )
    ]);
  }

  Widget _renderNumberSetChoice() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text("Number of sets",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                if (_nbSets > 0) {
                  setState(() {
                    _nbSets = _nbSets - 1;
                  });
                }
              },
              icon: const Icon(Icons.remove_circle, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:
                Text("$_nbSets", style: Theme.of(context).textTheme.headline4),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                setState(() {
                  _nbSets = _nbSets + 1;
                });
              },
              icon: const Icon(Icons.add_circle, color: Colors.white)),
        ],
      )
    ]);
  }

  Widget _renderSelectedExoWidget(ReferenceExercise exo) {
    return Center(
        child: Text("${exo.name}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)));
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
                        ? Container()
                        : _renderSelectedExoWidget(_selectedRefExo!)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(child: _renderNumberSetChoice()),
                                  Expanded(child: _renderRepsChoiceRow()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: _renderWeightChoiceRow(),
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
                            sets: List.generate(
                                _nbSets,
                                (index) => ExerciseSet(
                                    reps: _nbReps, weight: _weight)),
                            restBetweenSet: _restBtwSet);
                        BlocProvider.of<InWorkoutBloc>(context).add(
                            AddedExoEvent(
                                widget.tabController, _toAddExercise));
                      },
                      child: Text("Add this exercise"))
            ],
          ),
        )),
      ),
    );
  }
}
