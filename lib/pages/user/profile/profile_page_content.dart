import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/layouts/separator_overlapping_section_layout.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/preferences/preferences_page.dart';
import 'package:enter_training_me/pages/user/profile/profile_metric_container.dart';
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
                        Navigator.pop(context);
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
            future: _getUserFromTokenFuture,
            builder: (BuildContext context,
                AsyncSnapshot<IAuthUserInterface?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    return const Text("No User");
                  }
                  User user = snapshot.data as User;
                  return _renderProfile(user);
                default:
                  return const Text("Error");
              }
            },
          ),
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutRequested());
              },
              icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
    );
  }

  Widget _renderProfile(User user) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SeparatorOverlappingSectionLayout(
              topWidgetPadding: const EdgeInsets.only(bottom: 16),
              topWidgetBackgroundColor: CustomTheme.darkGrey,
              bottomWidgetBackgroundColor: CustomTheme.middleGreen,
              topWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                      child: Text(user.username,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _renderQuickInfos(),
                              _renderQuickInfos(),
                              _renderQuickInfos()
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
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
                          children: const [
                            Text("Title",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text(
                                "Fusce fermentum odio nec arcu. Sed magna purus, fermentum eu, tincidunt eu, varius ut, felis.",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      )
                    ],
                  )),
              bottomWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 16.0, top: 24),
                    child: Text("Last trainings",
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          double itemWidth =
                              MediaQuery.of(context).size.width / 2.5;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                width: itemWidth,
                                decoration: BoxDecoration(
                                    color: CustomTheme.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(children: [
                                  Image.asset("assets/exercises/pull_up.png",
                                      fit: BoxFit.cover),
                                  Container(
                                    alignment: Alignment.lerp(
                                        Alignment.topCenter,
                                        Alignment.bottomCenter,
                                        0.75),
                                    width: itemWidth,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      // color: Color.fromARGB(100, 255, 255, 255),
                                    ),
                                    child: const Text("Training"),
                                  )
                                ])),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 24.0, top: 32),
              child: Text("Dashboard",
                  style: Theme.of(context).textTheme.headline4),
            ),
            GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  ProfileMetricContainer(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("142"),
                      Text("trainings"),
                    ],
                  )),
                  ProfileMetricContainer(
                    child: Container(),
                  ),
                  ProfileMetricContainer(
                    child: Container(),
                  ),
                  ProfileMetricContainer(
                    child: Container(),
                  ),
                ]),
            Text("Email: ${user.email}"),
          ],
        ),
      ),
    );
  }

  Widget _renderQuickInfos() {
    return Column(
      children: [
        Text("Level".toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold)),
        Text("32")
      ],
    );
  }
}
