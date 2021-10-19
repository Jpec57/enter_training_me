import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  late Future<IAuthUserInterface?> _getUserFromTokenFuture;

  @override
  void initState() {
    super.initState();
    _getUserFromTokenFuture =
        RepositoryProvider.of<UserRepository>(context).getUserWithToken(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(
            onPressed: () {
              Get.toNamed(PreferencesPage.routeName);
            },
            icon: const Icon(Icons.settings, color: Colors.white)),
        FutureBuilder(
          future: _getUserFromTokenFuture,
          builder: (BuildContext context,
              AsyncSnapshot<IAuthUserInterface?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasData) {
                  return const Text("No User");
                }
                User user = snapshot.data as User;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Email: ${user.email}"),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AuthenticationLogoutRequested());
                        },
                        icon: const Icon(Icons.logout, color: Colors.white))
                  ],
                );
              default:
                return const Text("Error");
            }
          },
        ),
      ],
    );
  }
}
