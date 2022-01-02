import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/cached_request.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:enter_training_me/services/repositories/execution_style_repository.dart';
import 'package:enter_training_me/services/repositories/exercise_format_repository.dart';
import 'package:enter_training_me/services/repositories/performance_repository.dart';
import 'package:enter_training_me/services/repositories/ranking_repository.dart';
import 'package:enter_training_me/services/repositories/reference_exercise_repository.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<Widget> createApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CachedRequestAdapter());
  await Hive.openBox<CachedRequest>('request');

  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();
  final RankingRepository _rankingRepository = RankingRepository();
  final TrainingRepository _trainingRepository = TrainingRepository();
  final PerformanceRepository _perfRepository = PerformanceRepository();
  final ReferenceExerciseRepository _refExoRepository =
      ReferenceExerciseRepository();
  final ExecutionStyleRepository _execStyleRepository =
      ExecutionStyleRepository();
  final ExerciseFormatRepository _exoFormatRepository =
      ExerciseFormatRepository();

  return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _trainingRepository),
        RepositoryProvider.value(value: _refExoRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _execStyleRepository),
        RepositoryProvider.value(value: _exoFormatRepository),
        RepositoryProvider.value(value: _perfRepository),
        RepositoryProvider.value(value: _rankingRepository),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider.value(value: AppBloc()..add(OnInitEvent())),
        BlocProvider.value(
            value: AuthenticationBloc(
                authenticationRepository: _authRepository,
                userRepository: _userRepository)),
      ], child: const MyApp()));
}

Future<void> main() async {
  runApp(await createApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routing = MainRouting();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'EnterTrainingMe',
        restorationScopeId: 'root',
        key: Get.key,
        debugShowCheckedModeBanner: false,
        routeInformationParser: routing.goRouter.routeInformationParser,
        routerDelegate: routing.goRouter.routerDelegate,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // localizationsDelegates:  [
        //   AppLocalizations.delegate, // Add this line
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: Messages.supportedLocales
        //     .map((e) => Messages.getLocaleFromFullLocaleString(e))
        //     .toList(),
        locale: Get.deviceLocale ?? Messages.defaultLocale,
        // translations: Messages(),
        // fallbackLocale: Messages.defaultLocale,
        theme: CustomTheme.theme,
        // onGenerateRoute: (settings) => MainRouting.onGenerateRoutes(settings),
        // routes: MainRouting.routes(context),
        // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        //   builder: (context, state) {
        //     switch (state.status) {
        //       case AuthenticationStatus.authenticated:
        //         return const HomePage();
        //       case AuthenticationStatus.unauthenticated:
        //         return const HomePage();
        //       default:
        //         return const SplashPage();
        //     }
        //   },
        // ),
      ),
    );
  }
}
