import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:enter_training_me/services/repositories/execution_style_repository.dart';
import 'package:enter_training_me/services/repositories/exercise_format_repository.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
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
  final ReferenceExerciseRepository _refExoRepository =
      ReferenceExerciseRepository();
  final ExecutionStyleRepository _execStyleRepository =
      ExecutionStyleRepository();
  final ExerciseFormatRepository _exoFormatRepository =
      ExerciseFormatRepository();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _trainingRepository),
        RepositoryProvider.value(value: _refExoRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _execStyleRepository),
        RepositoryProvider.value(value: _exoFormatRepository),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider.value(value: AppBloc()..add(OnInitEvent())),
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
                  Get.offAll(MainRouting.home);
                  // Get.offAllNamed(HomePage.routeName);
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
