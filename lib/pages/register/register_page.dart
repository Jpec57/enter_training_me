import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  // final GlobalKey<Form
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) => RegisterBloc(),
      create: (context) => LoginBloc(),
      child: const RegisterPageContent(),
    );
  }
}

class RegisterPageContent extends StatelessWidget {
  const RegisterPageContent({Key? key}) : super(key: key);

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
                  child: Text("RegisterPage"),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Username",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                ),
              ),
              TextButton(
                child: Text(
                  "Already a member yet ? Log in",
                ),
                onPressed: () {
                  Get.toNamed(LoginPage.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
