import 'package:auto_animated/auto_animated.dart';
import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/log/bloc/log_bloc.dart';
import 'package:enter_training_me/pages/log/chronological_arrow.dart';
import 'package:enter_training_me/pages/workout_show/views/workout_edit_exercise_card.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogPage extends StatefulWidget {
  static const routeName = "/log";
  final int? userId;

  const LogPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  late Future<int?> _userIdFuture;

  Future<int?> getCurrentUserId() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? str = await storage.read(key: StorageConstants.userId);
    return str != null ? int.parse(str) : null;
  }

  @override
  void initState() {
    super.initState();
    _userIdFuture = (widget.userId != null)
        ? Future.value(widget.userId)
        : getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userIdFuture,
      builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
        var userId = snapshot.data;
        if (userId != null) {
          return BlocProvider(
              create: (context) => LogBloc(
                  userId: userId,
                  trainingRepository:
                      RepositoryProvider.of<TrainingRepository>(context))
                ..add(LoadLastTrainingEvent()),
              child: const LogPageContent());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child:
                  Text(Utils.defaultErrorMessage, textAlign: TextAlign.center),
            ),
          ),
        );
      },
    );
  }
}

class LogPageContent extends StatelessWidget {
  const LogPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardDown = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      floatingActionButton: isKeyboardDown
          ? CustomBottomNavigationBar.getCenteredFloatingButton()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedRoute: LogPage.routeName,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ChronologicalArrow(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 1, color: CustomTheme.middleGreen)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    BlocBuilder<LogBloc, LogState>(
                      buildWhen: (prev, next) =>
                          prev.hasPrevious != next.hasPrevious,
                      builder: (context, state) {
                        if (state.hasPrevious) {
                          return IconButton(
                              onPressed: () {
                                BlocProvider.of<LogBloc>(context).add(
                                    LoadPreviousTrainingEvent(
                                        referenceDate: DateTime.now()));
                              },
                              icon: const Icon(Icons.arrow_left));
                        }

                        return Container();
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: BlocBuilder<LogBloc, LogState>(
                          buildWhen: (prev, next) => prev != next,
                          builder: (context, state) {
                            if (state is LogTrainingLoadedState &&
                                state.visibleTraining.createdAt != null) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                    Utils.defaultVerboseDateFormatter.format(
                                        state.visibleTraining.createdAt!),
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("No date available",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline4),
                            );
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<LogBloc, LogState>(
                      buildWhen: (prev, next) => prev.hasNext != next.hasNext,
                      builder: (context, state) {
                        if (state.hasNext) {
                          return IconButton(
                              onPressed: () {
                                BlocProvider.of<LogBloc>(context).add(
                                    LoadNextTrainingEvent(
                                        referenceDate: DateTime.now()));
                              },
                              icon: const Icon(Icons.arrow_right));
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // color: Colors.red,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: BlocBuilder<LogBloc, LogState>(
                            builder: (context, state) {
                              if (state is LogTrainingLoadedState) {
                                return Text(state.visibleTraining.name,
                                    style:
                                        Theme.of(context).textTheme.headline4);
                              }
                              return Text("Training Name",
                                  style: Theme.of(context).textTheme.headline4);
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.settings)),
                      ],
                    ),
                    BlocBuilder<LogBloc, LogState>(
                      buildWhen: (prev, next) => prev != next,
                      builder: (context, state) {
                        if (state is LogTrainingLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is LogTrainingLoadedState) {
                          List<RealisedExercise> exos =
                              state.visibleTraining.exercises;
                          int exoLength = exos.length;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: LiveList.options(
                                options: const LiveOptions(),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:
                                    (context, i, Animation<double> animation) {
                                  return FadeTransition(
                                    opacity: Tween<double>(
                                      begin: 0,
                                      end: 1,
                                    ).animate(animation),
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, -0.1),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: WorkoutEditExerciseCard(
                                        exo: exos[i],
                                        isEditting: false,
                                        currentIndex: i,
                                        totalExoCount: exoLength,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: exoLength),
                          );
                        }
                        if (state is LogTrainingErrorState) {
                          return Center(
                              child: Text("Error : ${state.errorMessage}"));
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
