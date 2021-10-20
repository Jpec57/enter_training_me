import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/register/register_page.dart';
import 'package:enter_training_me/widgets/clippers/clipper_expo.dart';
import 'package:enter_training_me/widgets/clippers/clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({Key? key}) : super(key: key);
  final Color clipperColor = CustomTheme.middleGreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: HillsClipper(),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        color: clipperColor),
                  ),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.white, size: 40))),
                  const Center(
                      child: Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
          Expanded(
              child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (prev, next) =>
                                prev.username != next.username,
                            builder: (context, state) {
                              return TextFormField(
                                initialValue: state.username,
                                decoration: const InputDecoration(
                                    hintText: "Username/Email",
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(),
                                    hintStyle: TextStyle(color: Colors.white)),
                              );
                            },
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (prev, next) =>
                                prev.password != next.password,
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
                        ]),
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (prev, next) => prev.status != next.status,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  AuthenticationAttemptRequested(
                                      email: state.username,
                                      password: state.password));
                            },
                            child: const Icon(Icons.check, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                              primary: CustomTheme.greenSwatch,
                              onPrimary: CustomTheme.green,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Not a member yet ? Join us!",
                  ),
                  onPressed: () {
                    Get.toNamed(RegisterPage.routeName);
                  },
                ),
              ],
            ),
          )),
          // ClipPath(
          //   clipper: WavyLoginBottomClipper(),
          //   child: Container(
          //       height: 100,
          //       width: MediaQuery.of(context).size.width,
          //       color: clipperColor),
          // ),
        ],
      ),
    );
  }
}
