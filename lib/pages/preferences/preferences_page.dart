import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  static const routeName = "/preferences";
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile(
                title: Text("Sound"), value: true, onChanged: (value) {}),
            Container(),
          ],
        ),
      ),
    );
  }
}
