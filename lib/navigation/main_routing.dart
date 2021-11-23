import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:enter_training_me/pages/1rm/one_rm_page.dart';
import 'package:enter_training_me/pages/coaching/coach_page.dart';
import 'package:enter_training_me/pages/coaching/coach_page_arguments.dart';
import 'package:enter_training_me/pages/community/community_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_view_page_arguments.dart';
import 'package:enter_training_me/pages/exercise_view/exercise_view_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/log/log_page.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:enter_training_me/pages/test/test_page.dart';
import 'package:enter_training_me/pages/user/other_profile_page.dart';
import 'package:enter_training_me/pages/user/other_profile_page_arguments.dart';
import 'package:enter_training_me/pages/user/user_page.dart';
import 'package:enter_training_me/pages/workout_list/workout_list_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:flutter/material.dart';
import '../pages/workout_show/workout_show_page_arguments.dart';

class MainRouting {
  // static const home = OneRMPage();
  static const home = HomePage();
  // static const home = InWorkoutPage(
  // referenceTraining: Training(name: "Tmp Training", cycles: []),
  // );

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
        title: "Log",
        iconData: Icons.history,
        routeName: LogPage.routeName),
    NavigationElement(
        title: "Quick Countdown",
        iconData: Icons.timer,
        routeName: QuickCountdownPage.routeName),
  ];

  static onGenerateRoutes(settings) {
    if (settings.name == ExerciseViewPage.routeName) {
      var args = settings.arguments as ExerciseViewPageArguments;
      return MaterialPageRoute(builder: (context) => const ExerciseViewPage());
    }

    if (settings.name == InWorkoutPage.routeName) {
      var args = settings.arguments as InWorkoutPageArguments;
      return MaterialPageRoute(
          builder: (context) => InWorkoutPage(
                referenceTraining: args.referenceTraining,
              ));
    }
    if (settings.name == WorkoutShowPage.routeName) {
      var args = settings.arguments as WorkoutShowPageArguments;
      return MaterialPageRoute(
          builder: (context) => WorkoutShowPage(
                referenceTraining: args.referenceTraining,
              ));
    }
    if (settings.name == CoachPage.routeName) {
      var args = settings.arguments as CoachPageArguments;
      return MaterialPageRoute(
          builder: (context) => CoachPage(
                coach: args.coach,
              ));
    }
        if (settings.name == OtherProfilePage.routeName) {
      var args = settings.arguments as OtherProfilePageArguments;
      return MaterialPageRoute(
          builder: (context) => OtherProfilePage(
                user: args.user,
              ));
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  static routes(BuildContext context) => {
        HomePage.routeName: (context) => const HomePage(),
        CommunityPage.routeName: (context) => const CommunityPage(),
        PreferencesPage.routeName: (context) => const PreferencesPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        UserPage.routeName: (context) => const UserPage(),
        TestPage.routeName: (context) => const TestPage(),
        QuickCountdownPage.routeName: (context) => const QuickCountdownPage(),
        OneRMPage.routeName: (context) => const OneRMPage(),
        LogPage.routeName: (context) => const LogPage(),
        WorkoutListPage.routeName: (context) => const WorkoutListPage(),
        ExerciseListPage.routeName: (context) => const ExerciseListPage()
      };
}
