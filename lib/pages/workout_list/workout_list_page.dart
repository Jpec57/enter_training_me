import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              const Text("Workout list", style: TextStyle(color: Colors.white)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            context.go(InWorkoutPage.routeName);
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("Toto $i",
                                style: const TextStyle(color: Colors.black)),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
