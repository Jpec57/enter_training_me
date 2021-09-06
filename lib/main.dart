import 'package:ctraining/pages/exercise_list/exercise_list_page.dart';
import 'package:ctraining/pages/exercise_view/exercise_view_page.dart';
import 'package:ctraining/pages/home/home_page.dart';
import 'package:ctraining/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/exercise_list/exercise_view_page_arguments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CTraining',
      theme: CustomTheme.theme,
      onGenerateRoute: (settings){
        if (settings.name == ExerciseViewPage.routeName){
          var args = settings.arguments as ExerciseViewPageArguments;
          return MaterialPageRoute(builder: (context)=> const ExerciseViewPage());
        }

      },
      routes: {
        // HomePage.routeName: (context) => const HomePage(),
        ExerciseListPage.routeName: (context) => const ExerciseListPage()
      },
      home: const HomePage(),
    );
  }
}
