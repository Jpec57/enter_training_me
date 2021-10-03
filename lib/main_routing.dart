import 'package:enter_training_me/pages/1rm/one_rm_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_view_page_arguments.dart';
import 'package:enter_training_me/pages/exercise_view/exercise_view_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page_arguments.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:enter_training_me/pages/workout_list/workout_list_page.dart';
import 'package:flutter/material.dart';

class MainRouting {
  // static const home = OneRMPage();
  static const home = HomePage();

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
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  static routes(BuildContext context) => {
        HomePage.routeName: (context) => const HomePage(),
        QuickCountdownPage.routeName: (context) => const QuickCountdownPage(),
        OneRMPage.routeName: (context) => const OneRMPage(),
        WorkoutListPage.routeName: (context) => const WorkoutListPage(),
        ExerciseListPage.routeName: (context) => const ExerciseListPage()
      };
}
