import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/calculator/calculator_page.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:enter_training_me/translations/translations.dart';
import 'package:enter_training_me/widgets/flag_icon.dart';
import 'package:enter_training_me/widgets/multi_project/dialogs/change_language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PreferencesPage extends StatelessWidget {
  static const routeName = "/preferences";
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (prev, next) =>
                  prev.soundInWorkout != next.soundInWorkout,
              builder: (context, state) {
                return SwitchListTile(
                    title: const Text(
                      "Sound during workout",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: state.soundInWorkout == SoundInWorkout.on,
                    onChanged: (value) {
                      BlocProvider.of<AppBloc>(context).add(
                          OnPreferenceChangedEvent(
                              preferenceName:
                                  StorageConstants.soundInWorkoutKey,
                              value: value
                                  ? StorageConstants.soundInWorkoutOn
                                  : StorageConstants.soundInWorkoutOff));
                    });
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text("Calculate",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.toNamed(OneRMPage.routeName);
              },
            ),
            ListTile(
              leading: FlagIcon(countryCode: Get.locale?.countryCode),
              title: Text("language".tr,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                Get.dialog(ChangeLanguageDialog(
                    supportedLocales: Messages.supportedLocales
                        .map((e) => Messages.getLocaleFromFullLocaleString(e))
                        .toList(),
                    onLocaleChosen: (Locale locale) {
                      Get.updateLocale(locale);
                    }));
              },
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLogoutRequested());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.logout, color: Colors.white),
                    ),
                    Text("LOG OUT"),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
