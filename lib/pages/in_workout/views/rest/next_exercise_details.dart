import 'package:enter_training_me/models/realised_exercise.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_bloc.dart';
import 'package:enter_training_me/pages/in_workout/bloc/in_workout_state.dart';
import 'package:enter_training_me/pages/in_workout/views/new_exercise/add_new_exercise_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextExerciseDetail extends StatefulWidget {
  final RealisedExercise? nextExercise;
  final TabController tabController;
  const NextExerciseDetail(
      {Key? key, this.nextExercise, required this.tabController})
      : super(key: key);

  @override
  State<NextExerciseDetail> createState() => _NextExerciseDetailState();
}

class _NextExerciseDetailState extends State<NextExerciseDetail> {
  Widget _renderExerciseImage() {
    return Image.asset("assets/exercises/pull_up.png");
  }

  Widget _renderNextExoInfo(RealisedExercise? nextExo, int nextSetIndex) {
    if (nextExo == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${nextSetIndex + 1} / ${nextExo.sets.length} sets",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          nextExo.sets[nextSetIndex].weight != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${nextExo.sets[nextSetIndex].reps}@${nextExo.sets[nextSetIndex].weight} kgs",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _addExerciseSection() {
    return Center(
      child: AddNewExerciseSection(
        tabController: widget.tabController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InWorkoutBloc, InWorkoutState>(
      buildWhen: (prev, next) => prev.nextExoIndex != next.nextExoIndex,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      "Next: ${state.nextExo == null ? "End" : state.nextExo!.exerciseReference.name}",
                      style: Theme.of(context).textTheme.headline4,
                    )),
                  ],
                ),
              ),
              Expanded(
                child: state.nextExo == null
                    ? _addExerciseSection()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _renderExerciseImage(),
                          Expanded(
                              flex: 4,
                              child: _renderNextExoInfo(
                                  state.nextExo, state.nextSetIndex)),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
