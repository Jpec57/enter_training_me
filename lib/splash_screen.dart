import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: Center(
        child: Text('EnterTrainingMe'),
      ),
    );
  }
}
