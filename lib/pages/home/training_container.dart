import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingContainer extends StatelessWidget {
  const TrainingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Get.toNamed(InWorkoutPage.routeName);
    }, child: Builder(builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                  color: CustomTheme.middleGreen,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Positioned.fill(child: Image.asset("assets/exercises/pull_up.png")),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: CustomTheme.greenSwatch.shade700),
                  child: const Center(
                    child: Text("Training 2", style: TextStyle(fontSize: 30)),
                  ),
                )),
          ],
        ),
      );
    }));
  }
}
