import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/workout_show/bloc/bloc/workout_edit_bloc.dart';
import 'package:enter_training_me/pages/workout_show/section_title.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page_content.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/analysis/current/muscle_activation_repartition_graph.dart';
import 'package:enter_training_me/widgets/analysis/current/workout_exercise_intensity_graph.dart';
import 'package:enter_training_me/widgets/analysis/current/training_type_repartition_graph.dart';
import 'package:enter_training_me/widgets/analysis/history/workout_history_evolution.dart';
import 'package:enter_training_me/widgets/section_divider.dart';
import 'package:enter_training_me/widgets/workout/workout_training_summary_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'views/workout_info_view.dart';
part 'views/workout_history_view.dart';

class WorkoutShowPage extends StatefulWidget{
  const WorkoutShowPage(
      {Key? key, required this.referenceTraining, this.isEditing = false})
      : super(key: key);
  static const routeName = "/workout/show";
  final Training referenceTraining;
  final bool isEditing;

  @override
  State<WorkoutShowPage> createState() => _WorkoutShowPageState();
}

class _WorkoutShowPageState extends State<WorkoutShowPage> with RestorationMixin{
    final RestorableInt _index = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutEditBloc>(
      lazy: false,
      create: (context) => WorkoutEditBloc(
          RepositoryProvider.of<TrainingRepository>(context), widget.referenceTraining,
          isEditingAtStartAlready: widget.isEditing),
      child: WorkoutShowPageContent(referenceTraining: widget.referenceTraining),
    );
  }

  @override
  String get restorationId => 'workout_show_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
      // registerForRestoration(_index, 'nav_bar_index');
  }
}
