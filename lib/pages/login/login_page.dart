import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/login/views/login_form_view.dart';
import 'package:enter_training_me/pages/profile/profile_page_content.dart';
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
          onLoginCallback: () {
            // saveUserToken
            // RepositoryProvider.of<AuthenticationRepository>(context).saveUserToken(token)
            // BlocProvider.of<AuthenticationBloc>(context).add(
            // AuthenticationAttemptRequested());
          },
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
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    buildWhen: (prev, next) => prev != next,
                    builder: (context, state) {
                      if (state.status == AuthenticationStatus.authenticated) {
                        return const ProfilePageContent();
                      }
                      return const LoginFormView();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
