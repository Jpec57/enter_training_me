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
  double? _weight;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _renderIntRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_circle, color: Colors.white)),
        Column(children: [
          Text("Number of sets"),
          Text("4"),
        ]),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle, color: Colors.white)),
      ],
    );
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
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      BlocProvider.of<InWorkoutBloc>(context).add(
                          ChangedViewEvent(widget.tabController,
                              InWorkoutView.endWorkoutView));
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
                    height: min(size.width, size.height) * 0.5,
                    width: min(size.width, size.height) * 0.5,
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
                            _renderIntRow(),
                            _renderIntRow(),
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
