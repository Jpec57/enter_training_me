import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

class ProfileLastTrainingSection extends StatelessWidget {
  final List<Training> lastTrainings;
  const ProfileLastTrainingSection({Key? key, required this.lastTrainings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16.0, top: 24),
          child: Text("Last trainings",
              style: Theme.of(context).textTheme.headline4),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lastTrainings.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                double itemWidth = MediaQuery.of(context).size.width / 2.5;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                      width: itemWidth,
                      decoration: BoxDecoration(
                          color: CustomTheme.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(children: [
                        Image.asset("assets/exercises/pull_up.png",
                            fit: BoxFit.cover),
                        Container(
                          alignment: Alignment.lerp(Alignment.topCenter,
                              Alignment.bottomCenter, 0.75),
                          width: itemWidth,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            // color: Color.fromARGB(100, 255, 255, 255),
                          ),
                          child: Text(lastTrainings[i].name),
                        )
                      ])),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
