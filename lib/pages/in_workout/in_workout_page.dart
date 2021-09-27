import 'package:ctraining/custom_theme.dart';
import 'package:ctraining/pages/in_workout/in_workout_exercise_view.dart';
import 'package:ctraining/pages/in_workout/in_workout_rest_view.dart';
import 'package:ctraining/pages/in_workout/ui_parts/current_exercise_details.dart';
import 'package:ctraining/pages/in_workout/ui_parts/training_progress_bar.dart';
import 'package:flutter/material.dart';

class InWorkoutPage extends StatefulWidget {
  static const routeName = "/workout/in";

  const InWorkoutPage({Key? key}) : super(key: key);

  @override
  State<InWorkoutPage> createState() => _InWorkoutPageState();
}

class _InWorkoutPageState extends State<InWorkoutPage> with TickerProviderStateMixin{

  late TabController _tabController;

  Widget _renderDoneButton(BuildContext context) {
    return InkWell(onTap: (){

    }, child: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomTheme.darkGrey,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: Text("Done".toUpperCase(), style: TextStyle(fontSize: 30),))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
              child: TrainingProgressBar(),
            ),
            Expanded(child: TabBarView(
                controller: _tabController,
                children: [InWorkoutExerciseView(), InWorkoutRestView()])),
            _renderDoneButton(context),
          ],
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
