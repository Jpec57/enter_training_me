import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/register/bloc/bloc/register_bloc.dart';
import 'package:enter_training_me/pages/user/user_page.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context)),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      children: [
                        IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              Get.toNamed(HomePage.routeName);
                            },
                            icon: const Icon(Icons.chevron_left,
                                color: Colors.white, size: 40)),
                        Expanded(
                            child: Center(
                                child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.headline3,
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: "jpec2@test.fr",
                      decoration: const InputDecoration(
                        hintText: "Username",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: "jpec2@test.fr",
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      obscureText: true,
                      initialValue: "test",
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      obscureText: true,
                      initialValue: "test",
                      decoration: const InputDecoration(
                        hintText: "Confirm password",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      buildWhen: (prev, next) => prev.status != next.status,
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<RegisterBloc>(context)
                                  .add(const RegisterSubmitted());
                            },
                            child: const Text("Submit"));
                      },
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Already a member yet ? Log in",
                    ),
                    onPressed: () {
                      Get.toNamed(UserPage.routeName);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
