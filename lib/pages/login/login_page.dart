import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("LoginPage"),
          ),
        ),
      ),
    );
  }
}
