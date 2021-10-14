import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:enter_training_me/pages/1rm/one_rm_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_view_page_arguments.dart';
import 'package:enter_training_me/pages/exercise_view/exercise_view_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/login/login_page.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/pages/profile/profile_page.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:enter_training_me/pages/test/test_page.dart';
import 'package:enter_training_me/pages/workout_list/workout_list_page.dart';
import 'package:enter_training_me/pages/workout_show/workout_show_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/workout_show/workout_show_page_arguments.dart';

class MainRouting {
  // static const home = OneRMPage();
  static const home = TestPage();

  static const homeNavigationElement = NavigationElement(
    title: "Home",
    iconData: Icons.home,
    routeName: HomePage.routeName,
  );

  static const mainNavigationElements = [
    NavigationElement(
        title: "Profile",
        iconData: Icons.person,
        routeName: ProfilePage.routeName),
    NavigationElement(
        title: "Other",
        iconData: Icons.question_answer,
        routeName: HomePage.routeName),
    NavigationElement(
        title: "1RM Calculator",
        iconData: Icons.calculate,
        routeName: OneRMPage.routeName),
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
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  static routes(BuildContext context) => {
        HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        PreferencesPage.routeName: (context) => const PreferencesPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        TestPage.routeName: (context) => const TestPage(),
        QuickCountdownPage.routeName: (context) => const QuickCountdownPage(),
        OneRMPage.routeName: (context) => const OneRMPage(),
        WorkoutListPage.routeName: (context) => const WorkoutListPage(),
        ExerciseListPage.routeName: (context) => const ExerciseListPage()
      };
}
