import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/main_routing.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final UserRepository _userRepository = new UserRepository();
  runApp(const MyApp());
  // runApp(MultiRepositoryProvider(
  //     providers: const [],
  //     child: MultiBlocProvider(
  //         providers: const [],
  //     child: const MyApp()))
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'enter_training_me',
        theme: CustomTheme.theme,
        onGenerateRoute: (settings) =>
            MainRouting.onGenerateRoutes(settings),
        routes: MainRouting.routes(context),
        home: MainRouting.home,
      ),
    );
  }
}
