import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/workout_show/workout_metric.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutShowPage extends StatefulWidget {
  final Training referenceTraining;
  static const routeName = "/workout/show";

  const WorkoutShowPage({Key? key, required this.referenceTraining})
      : super(key: key);

  @override
  State<WorkoutShowPage> createState() => _WorkoutShowPageState();
}

class _WorkoutShowPageState extends State<WorkoutShowPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late Future<List<Training>> _historyTrainings;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _historyTrainings = RepositoryProvider.of<TrainingRepository>(context)
        .getByReference(widget.referenceTraining.id!);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.referenceTraining.name,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            const SectionDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 24,
                children: [
                  widget.referenceTraining.estimatedTimeInSeconds != null
                      ? WorkoutMetric(
                          metric:
                              "${widget.referenceTraining.estimatedTimeInSeconds! ~/ 60}",
                          unit: " min")
                      : Container(),
                  Text("EXPERT", style: GoogleFonts.bebasNeue(fontSize: 25)),
                  InkWell(
                    onTap: () async {
                      List<Training> doneTrainings =
                          await RepositoryProvider.of<TrainingRepository>(
                                  context)
                              .getByReference(widget.referenceTraining.id!);
                      print(doneTrainings);
                      print(doneTrainings.length);
                      _tabController.index = 1;
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("History",
                            style: GoogleFonts.bebasNeue(fontSize: 25)),
                        const Icon(
                          Icons.history,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SectionDivider(),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WorkoutTrainingContent(
                          referenceTraining: widget.referenceTraining),
                      const SectionDivider(),
                    ],
                  ),
                ),
                FutureBuilder(
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
                      return ListView.builder(
                          itemCount: oldTrainings.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text(oldTrainings[index].name),
                              children: [
                                Text("hello"),
                                Text("ca va"),
                              ],
                            );
                          });
                    }

                    return Text("Error");
                  },
                ),
              ]),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(InWorkoutPage.routeName,
                    arguments: InWorkoutPageArguments(
                        referenceTraining: widget.referenceTraining));
              },
              child: const Text("Start workout"),
            ),
          ]),
        ),
      ),
    );
  }
}
