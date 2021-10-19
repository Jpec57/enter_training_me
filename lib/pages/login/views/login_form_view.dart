import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white)),
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
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationAttemptRequested(
                            email: state.username, password: state.password));
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
    );
  }
}
