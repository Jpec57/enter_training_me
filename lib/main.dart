import 'package:ctraining/pages/exercise_list/exercise_list_page.dart';
import 'package:ctraining/pages/home/home_page.dart';
import 'package:ctraining/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CTraining',
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
        primarySwatch: CustomTheme.redBlackSwatch,
      ),
      routes: {
        ExerciseListPage.routeName: (context) => const ExerciseListPage()
      },
      home: const HomePage(),
    );
  }
}
