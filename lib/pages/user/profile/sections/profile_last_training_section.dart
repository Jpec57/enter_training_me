import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

class ProfileLastTrainingSection extends StatelessWidget {
  final List<Training> lastTrainings;
  const ProfileLastTrainingSection({Key? key, required this.lastTrainings})
      : super(key: key);

  Widget _renderTrainingContainer(double itemWidth, Training training) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
              color: CustomTheme.grey, borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            Image.asset("assets/exercises/pull_up.png", fit: BoxFit.cover),
            Align(
                alignment: const Alignment(0, 0.75),
                child: Container(
                  width: itemWidth,
                  height: itemWidth * 0.25,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  child: Center(
                    child: Text(training.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 2.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        )),
                  ),
                )),
          ])),
    );
  }

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
        (lastTrainings.isEmpty)
            ? const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Center(
                  child: Text("No training realised."),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: lastTrainings.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      double itemWidth =
                          MediaQuery.of(context).size.width / 2.5;
                      return _renderTrainingContainer(
                          itemWidth, lastTrainings[i]);
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
