import 'package:enter_training_me/models/reference_exercise.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/choose_exercise_dialog.dart';
import 'package:enter_training_me/pages/test/video_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentExerciseDetail extends StatefulWidget {
  final ReferenceExercise referenceExercise;
  const CurrentExerciseDetail({Key? key, required this.referenceExercise})
      : super(key: key);

  @override
  State<CurrentExerciseDetail> createState() => _CurrentExerciseDetailState();
}

class _CurrentExerciseDetailState extends State<CurrentExerciseDetail> {
  bool _isShowingDescription = false;

  // Widget _renderExerciseDescription() {
  //   String description = widget.referenceExercise.description != null &&
  //           widget.referenceExercise.description!.isNotEmpty
  //       ? widget.referenceExercise.description!
  //       : "No description available.";
  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [Text(description)],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    String description = widget.referenceExercise.description != null &&
            widget.referenceExercise.description!.isNotEmpty
        ? widget.referenceExercise.description!
        : "No description available.";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_circle_down_sharp),
                onPressed: () {},
              ),
              Flexible(
                  child: InkWell(
                onTap: () {
                  Get.dialog(ChooseExerciseDialog(
                    onExerciseChosen: (ReferenceExercise exo) {
                      BlocProvider.of<InWorkoutBloc>(context)
                          .add(ChangedExoEvent(exo));
                    },
                  ));
                },
                child: BlocBuilder<InWorkoutBloc, InWorkoutState>(
                  buildWhen: (prev, next) => prev.currentExo != next.currentExo,
                  builder: (context, state) {
                    return Text(
                      widget.referenceExercise.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.permanentMarker(
                          color: Colors.white, fontSize: 30),
                    );
                  },
                ),
              )),
              IconButton(
                icon: const Icon(Icons.arrow_circle_up_sharp),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _isShowingDescription = !_isShowingDescription;
                });
              },
              child: VideoContent(
                path: 'assets/exercises/push_up.mov',
                thumbnailPath: 'assets/exercises/pull_up.png',
                isNetwork: false,
                stackChildren: [
                  _isShowingDescription
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(130)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(description),
                                  const Text(
                                      "Sed hendrerit. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. Aliquam lobortis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.In hac habitasse platea dictumst. Maecenas malesuada. Curabitur vestibulum aliquam leo. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi.Donec sodales sagittis magna. Cras dapibus. Fusce a quam. Praesent adipiscing."),
                                  const Text(
                                      "Sed hendrerit. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. Aliquam lobortis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.In hac habitasse platea dictumst. Maecenas malesuada. Curabitur vestibulum aliquam leo. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi.Donec sodales sagittis magna. Cras dapibus. Fusce a quam. Praesent adipiscing."),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
