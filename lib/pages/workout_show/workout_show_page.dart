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
import 'package:go_router/go_router.dart';

part 'views/workout_info_view.dart';
part 'views/workout_history_view.dart';

class WorkoutShowPage extends StatefulWidget {
  const WorkoutShowPage(
      {Key? key, required this.trainingId, this.isEditing = false})
      : super(key: key);
      
  static const name = "WorkoutShow";
  static const routeName = "/workout/:id";
  final int? trainingId;
  final bool isEditing;

  @override
  State<WorkoutShowPage> createState() => _WorkoutShowPageState();
}

class _WorkoutShowPageState extends State<WorkoutShowPage>
// with RestorationMixin
{
  // final RestorableInt _index = RestorableInt(0);
  late Future<Training> _trainingFuture;

  @override
  void initState() {
    super.initState();
    if (widget.trainingId != null && widget.trainingId != 0) {
      _trainingFuture = RepositoryProvider.of<TrainingRepository>(context)
          .get(widget.trainingId!);
    } else {
      _trainingFuture = Future.value(Training.empty());
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return FutureBuilder(
      future: _trainingFuture,
      builder: (BuildContext context, AsyncSnapshot<Training> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          Training referenceTraining = snapshot.data!;
          return BlocProvider<WorkoutEditBloc>(
            lazy: false,
            create: (context) => WorkoutEditBloc(
                router,
                RepositoryProvider.of<TrainingRepository>(context),
                referenceTraining,
                isEditingAtStartAlready: widget.isEditing),
            child: WorkoutShowPageContent(referenceTraining: referenceTraining),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // @override
  // String get restorationId => 'workout_show_page';

  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //     // registerForRestoration(_index, 'nav_bar_index');
  // }
}
