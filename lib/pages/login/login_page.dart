import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
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
      create: (context) => LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const LoginPageContent(),
    );
  }
}

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Form(
            child: Column(
              children: [
                const Center(
                  child: Text("LoginPage"),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, next) => prev.username != next.username,
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.username,
                      decoration: const InputDecoration(
                        hintText: "Username/Email",
                      ),
                    );
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, next) => prev.password != next.password,
                  builder: (context, state) {
                    return TextFormField(
                      obscureText: true,
                      initialValue: state.password,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (prev, next) => prev.status != next.status,
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(const LoginSubmitted());
                          },
                          child: const Text("Submit"));
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
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
      ),
    );
  }
}
