import 'package:auto_animated/auto_animated.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/layouts/separator_overlapping_section_layout.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/profile_info.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/pages/user/profile/sections/profile_header.dart';
import 'package:enter_training_me/pages/user/profile/profile_metric_container.dart';
import 'package:enter_training_me/pages/user/profile/sections/profile_last_training_section.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/analysis/history/exercise_history_evolution.dart';
import 'package:enter_training_me/widgets/analysis/user/exercised_muscle_radar_repartition_graph.dart';
import 'package:enter_training_me/widgets/animations/animated_count_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'sections/profile_metrics_section.dart';

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  late Future<ProfileInfo?> _getUserProfileInfosFuture;
  late Future<List<ReferenceExercise>>? _realisedExoReferencesFuture;

  @override
  void initState() {
    super.initState();
    _getUserProfileInfosFuture =
        RepositoryProvider.of<UserRepository>(context).getUserProfileInfo(null);
    _realisedExoReferencesFuture =
        RepositoryProvider.of<UserRepository>(context)
            .getRealisedExoForViewer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: CustomTheme.darkGrey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Get.toNamed(HomePage.routeName);
                      },
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 40)),
                  const Expanded(
                      child: Center(
                          child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ))),
                  IconButton(
                      onPressed: () {
                        Get.toNamed(PreferencesPage.routeName);
                      },
                      icon: const Icon(Icons.settings, color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getUserProfileInfosFuture,
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileInfo?> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (!snapshot.hasData) {
                      return const Text("No User");
                    }
                    ProfileInfo info = snapshot.data!;
                    return _renderProfile(info);
                  default:
                    return const Text("Error");
                }
              },
            ),
          ),
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutRequested());
              },
              icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
    );
  }

  Widget _renderProfile(ProfileInfo info) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SeparatorOverlappingSectionLayout(
            topWidgetPadding: const EdgeInsets.only(bottom: 16),
            topWidgetBackgroundColor: CustomTheme.darkGrey,
            bottomWidgetBackgroundColor: CustomTheme.middleGreen,
            topWidget: ProfileHeader(
              user: info.user,
            ),
            overlappingWidget: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.access_alarm),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Map<String, dynamic> map = {"description": "TOTO"};
                          User? updatedUser =
                              await RepositoryProvider.of<UserRepository>(
                                      context)
                                  .updateUser(info.user.id, map);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                  info.user.description ?? "No description",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            bottomWidget: ProfileLastTrainingSection(
              lastTrainings: info.lastTrainings.reversed.toList(),
            ),
          ),
          ProfileMetricsSection(info: info),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 32, bottom: 16),
            child: Text(
              "Exercise Estimated 1RM Progression",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          FutureBuilder(
            future: _realisedExoReferencesFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<ReferenceExercise>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.isNotEmpty) {
                List<ReferenceExercise> exos = snapshot.data!;
                return ExerciseHistoryEvolution(
                  referenceExercises: exos,
                );
              }
              return const Center(
                child: Text("No data"),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 32),
            child: Text("Muscle Profile",
                style: Theme.of(context).textTheme.headline4),
          ),
          ExercisedMuscleRadarRepartitionGraph(
              muscleExperiences: info.user.fitnessProfile!.muscleExperiences)
        ],
      ),
    );
  }
}
