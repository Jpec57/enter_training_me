import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:enter_training_me/pages/calculator/calculator_page.dart';
import 'package:enter_training_me/pages/coaching/coach_page.dart';
import 'package:enter_training_me/pages/community/community_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/pages/exercise_view/exercise_view_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/log/log_page.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:enter_training_me/pages/test/test_page.dart';
import 'package:enter_training_me/pages/user/other_profile_page.dart';
import 'package:enter_training_me/pages/user/user_page.dart';
import 'package:enter_training_me/pages/workout_list/workout_list_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainRouting {
  static const home = HomePage();

  static const homeNavigationElement = NavigationElement(
    title: "Home",
    iconData: Icons.home,
    routeName: HomePage.routeName,
  );

  static const mainNavigationElements = [
    NavigationElement(
        title: "Profile",
        iconData: Icons.person,
        routeName: UserPage.routeName),
    NavigationElement(
        title: "Other",
        iconData: Icons.public,
        routeName: CommunityPage.routeName),
    NavigationElement(
        title: "Log", iconData: Icons.history, routeName: LogPage.routeName),
    NavigationElement(
        title: "Quick Countdown",
        iconData: Icons.timer,
        routeName: QuickCountdownPage.routeName),
  ];

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: CoachPage.routeName,
        builder: (context, state) {
          var coachUserId = int.parse(state.queryParameters['id']!);
          return CoachPage(
            coachUserId: coachUserId,
          );
        },
      ),
      GoRoute(
        path: LogPage.routeName,
        builder: (context, state) {
          int? userId;
          // try {
          //   userId = (state.params['id'] != null)
          //       ? int.parse(state.params['id']!)
          //       : 0;
          // } on Exception catch (_) {
          //   userId = null;
          // }
          return LogPage(
            userId: userId,
          );
        },
      ),
      GoRoute(
        name: WorkoutShowPage.name,
        path: WorkoutShowPage.routeName,
        builder: (context, state) {
          final isEditing = state.queryParameters['isEditing'] == "1";
          var trainingId = int.parse(state.queryParameters['id']!);
          return WorkoutShowPage(
            trainingId: trainingId,
            isEditing: isEditing,
          );
        },
      ),
      GoRoute(
        path: OtherProfilePage.routeName,
        builder: (context, state) {
          var userId = int.parse(state.queryParameters['id']!);
          return OtherProfilePage(
            userId: userId,
          );
        },
      ),
      GoRoute(
        name: 'InWorkoutPage',
        path: InWorkoutPage.routeName,
        builder: (context, state) {
          final queryRefId = state.queryParameters['id'];
          return InWorkoutPage(
            referenceTrainingId:
                queryRefId != null ? int.parse(queryRefId) : null,
          );
        },
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: ExerciseViewPage.routeName,
        builder: (context, state) => const ExerciseViewPage(),
      ),
      GoRoute(
        path: CommunityPage.routeName,
        builder: (context, state) => const CommunityPage(),
      ),
      GoRoute(
        path: PreferencesPage.routeName,
        builder: (context, state) => const PreferencesPage(),
      ),
      GoRoute(
        path: WorkoutListPage.routeName,
        builder: (context, state) => const WorkoutListPage(),
      ),
      GoRoute(
        path: ExerciseListPage.routeName,
        builder: (context, state) => const ExerciseListPage(),
      ),
      GoRoute(
        path: OneRMPage.routeName,
        builder: (context, state) => const OneRMPage(),
      ),
      GoRoute(
        path: QuickCountdownPage.routeName,
        builder: (context, state) => const QuickCountdownPage(),
      ),
      GoRoute(
        path: TestPage.routeName,
        builder: (context, state) => const TestPage(),
      ),
      GoRoute(
        path: UserPage.routeName,
        builder: (context, state) => const UserPage(),
      ),
      GoRoute(
        path: RegisterPage.routeName,
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
