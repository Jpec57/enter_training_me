import 'package:ctraining/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';

class WorkoutListPage extends StatefulWidget {
  static const routeName = "/workouts";

  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Workout list", style: TextStyle(color: Colors.white)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                // child: ListView.builder(
                //   shrinkWrap: true,
                //     itemCount: 10,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, i){
                //   return Container(
                //     height: 200, width: 200,
                //     decoration: BoxDecoration(color: Colors.white),
                //     child: Text("Toto $i"),
                //   );
                // }),
              ),
              Container(
                  // color: Colors.green,
                  child: CountdownTimer(totalDuration: 60,)),
            ],
          ),
        ),
      ),
    );
  }
}
