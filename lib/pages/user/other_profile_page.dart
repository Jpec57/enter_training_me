import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/layouts/separator_overlapping_section_layout.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';

import 'package:enter_training_me/pages/user/profile/sections/profile_header.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class OtherProfilePage extends StatefulWidget {
  static const routeName = "profile/other";
  final int userId;

  const OtherProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  late Future<User> _userFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = RepositoryProvider.of<UserRepository>(context)
        .get(widget.userId);
  }

  Widget _renderProfile(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SeparatorOverlappingSectionLayout(
            topWidgetPadding: const EdgeInsets.only(bottom: 16),
            topWidgetBackgroundColor: CustomTheme.darkGrey,
            bottomWidgetBackgroundColor: CustomTheme.middleGreen,
            topWidget: ProfileHeader(
              user: user,
            ),
            overlappingWidget: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.access_alarm),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(user.description ?? "No description",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            bottomWidget: Container(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: CustomTheme.darkGrey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Get.toNamed(HomePage.routeName);
                      },
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 40)),
                  const Expanded(
                      child: Center(
                          child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ))),
                  IconButton(
                      onPressed: () {
                        Get.toNamed(PreferencesPage.routeName);
                      },
                      icon: const Icon(Icons.settings, color: Colors.white)),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: _userFuture,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.data != null &&
                  snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: _renderProfile(context, snapshot.data!),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
