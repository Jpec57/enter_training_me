import 'package:ctraining/pages/exercise_list/exercise_list_page.dart';
import 'package:ctraining/pages/exercise_list/exercise_view_page_arguments.dart';
import 'package:ctraining/pages/exercise_view/exercise_view_page.dart';
import 'package:ctraining/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class MainRouting {
  static onGenerateRoutes(settings) {
    if (settings.name == ExerciseViewPage.routeName){
      var args = settings.arguments as ExerciseViewPageArguments;
      return MaterialPageRoute(builder: (context)=> const ExerciseViewPage());
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  static routes(BuildContext context) => {
    HomePage.routeName: (context) => const HomePage(),
    ExerciseListPage.routeName: (context) => const ExerciseListPage()
  };
}