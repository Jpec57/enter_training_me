part of '../../in_workout_page.dart';

class NewExerciseView extends StatefulWidget {
  final TabController tabController;

  const NewExerciseView({Key? key, required this.tabController})
      : super(key: key);

  @override
  _NewExerciseViewState createState() => _NewExerciseViewState();
}

class _NewExerciseViewState extends State<NewExerciseView> {
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
                Get.dialog(const ChooseExerciseDialog());
              },
              child: Container(
                  decoration: const BoxDecoration(color: Colors.amber),
                  height: min(size.width, size.height) * 0.5,
                  width: min(size.width, size.height) * 0.5,
                  child: Container()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _renderIntRow(),
                  _renderIntRow(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
