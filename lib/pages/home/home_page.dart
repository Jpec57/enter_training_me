import 'package:carousel_slider/carousel_slider.dart';
import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/workout/training_container.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/widgets/clippers/diagonal_corner_clipper.dart';
import 'package:enter_training_me/widgets/dialog/confirm_dialog.dart';
import 'package:enter_training_me/widgets/texts/headline3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Training>> _trainingFuture;
  late Future<List<Training>>? _savedTrainingFuture;

  @override
  void initState() {
    _savedTrainingFuture =
        RepositoryProvider.of<TrainingRepository>(context).getSavedTrainings();
    _trainingFuture =
        RepositoryProvider.of<TrainingRepository>(context).getOfficial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppBloc>(context);
    return Scaffold(
      floatingActionButton: CustomBottomNavigationBar.getCenteredFloatingButton(
          context,
          isSelected: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedRoute: HomePage.routeName,
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  buildWhen: (prev, next) => prev.user != next.user,
                  builder: (context, state) {
                    if (state.user == null) {
                      return Text(
                          // AppLocalizations.of(context).welcome_anonymous,
                          'AppLocalizations.of(context).welcome_anonymous',
                          style: Theme.of(context).textTheme.headline4);
                    }
                    User user = state.user as User;
                    return Text(
                        'welcome_back_username'
                            .trParams({'username': user.username}),
                        style: Theme.of(context).textTheme.headline4);
                  },
                ),
              ),
              Stack(fit: StackFit.loose, children: [
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Container(
                    color: CustomTheme.grey,
                  ),
                )),
                Positioned.fill(
                    child: ClipPath(
                  clipper: DiagonalCornerClipper(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    color: CustomTheme.darkGrey,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _renderOfficialWorkoutSection(),
                ),
              ]),
              _renderSavedWorkoutSection(),
              Container(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderOfficialWorkoutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Headline4(title: "official_workouts".tr),
              ],
            ),
          ),
          FutureBuilder(
            future: _trainingFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Training>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.data == null) {
                    return Text("empty".tr);
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: snapshot.data!.map((training) {
                      return TrainingContainer(
                        referenceTraining: training,
                      );
                    }).toList(),
                  );
                case ConnectionState.waiting:
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      TrainingContainer(
                        isClickDisabled: true,
                        referenceTraining: Training(
                            name: "loading".tr,
                            exercises: const [],
                            intensity: 0,
                            numberOfLoops: 1),
                      )
                    ],
                  );
                default:
                  return Center(child: Text("error".tr));
              }
            },
          )
        ],
      ),
    );
  }

  void _onNewPersonalWorkoutButtonTap() async {
    bool? autoPlay = await showDialog(
        context: context,
        builder: (dialogContext) {
          return ConfirmDialog(
            title: "direct_play_or_save_for_later".tr,
            message: "create_as_you_go".tr,
            confirmLabel: "auto_play".tr,
            cancelLabel: "create_for_later".tr,
            confirmCallback: () {
              Navigator.of(context).pop<bool>(true);
            },
            cancelCallback: () {
              Navigator.of(context).pop<bool>(false);
            },
          );
        });
    if (autoPlay != null) {
      if (autoPlay) {
        context.pushNamed(
          InWorkoutPage.name,
        );
      } else {
        context.pushNamed(WorkoutShowPage.name,
            pathParameters: {"id": 0.toString()},
            queryParameters: {"id": 0.toString(), "isEditing": "1"});
      }
    }
  }

  Widget _renderSavedWorkoutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 32, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Headline4(title: "personal_workouts".tr),
              InkWell(
                  onTap: _onNewPersonalWorkoutButtonTap,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: Text("create".tr.toUpperCase()))),
            ],
          ),
        ),
        FutureBuilder(
          future: _savedTrainingFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Training>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.data == null) {
                  return Text("empty".tr);
                }
                return CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.4,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: snapshot.data!.map((training) {
                    return TrainingContainer(
                      referenceTraining: training,
                    );
                  }).toList(),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Center(child: Text("error".tr));
            }
          },
        )
      ],
    );
  }
}
