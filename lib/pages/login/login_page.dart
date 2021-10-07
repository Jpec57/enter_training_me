import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  // final GlobalKey<Form

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginPageContent(),
    );
  }
}

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text("LoginPage"),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Username/Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              TextButton(
                child: Text(
                  "Not a member yet ? Join us!",
                ),
                onPressed: () {
                  Get.toNamed(RegisterPage.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
