import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/login/bloc/login_bloc.dart';
import 'package:enter_training_me/pages/user/profile/profile_page_content.dart';
import 'package:enter_training_me/pages/user/views/login_form_view.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  static const routeName = "/login";

  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          onLoginCallback: () {},
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
      extendBodyBehindAppBar: true,
      backgroundColor: CustomTheme.darkGrey,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (prev, next) => prev.user != next.user,
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const ProfilePageContent();
          }
          return const LoginFormView();
        },
      ),
    );
  }
}
