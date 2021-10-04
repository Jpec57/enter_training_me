import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/pages/exercise_list/exercise_list_page.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/main_routing.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/login/login_page.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();
  final TrainingRepository _trainingRepository = TrainingRepository();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _trainingRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _authRepository)
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider.value(
            value: AuthenticationBloc(
                authenticationRepository: _authRepository,
                userRepository: _userRepository)),
      ], child: const MyApp())));
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
        onGenerateRoute: (settings) => MainRouting.onGenerateRoutes(settings),
        routes: MainRouting.routes(context),
        builder: (BuildContext context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  print("authenticated");
                  Get.offNamedUntil(HomePage.routeName, (route) => false);
                  break;
                // case AuthenticationStatus.unauthenticated:
                //   print("unauthenticated");
                //   Get.offNamedUntil(LoginPage.routeName, (route) => false);
                //   break;
                default:
                  break;
              }
            },
            child: child,
          );
        },
        home: MainRouting.home,
      ),
    );
  }
}
