import 'package:carousel_slider/carousel_slider.dart';
import 'package:enter_training_me/app_preferences/bloc/app_bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/drawer.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/training_container.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/texts/headline3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_io.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Training>> _trainingFuture;
  late Future<List<Training>> _feedFuture;

  @override
  void initState() {
    _trainingFuture =
        RepositoryProvider.of<TrainingRepository>(context).getOfficial();
    _feedFuture =
        RepositoryProvider.of<UserRepository>(context).getPersonalFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      // extendBody: true,
      floatingActionButton:
          CustomBottomNavigationBar.getCenteredFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                buildWhen: (prev, next) => prev.user != next.user,
                builder: (context, state) {
                  if (state.user == null) {
                    return Text("Welcome !",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 35));
                  }
                  User user = state.user as User;
                  return Text("Welcome back ${user.username}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 35));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 32, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Headline3(title: "Workouts"),
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          "More...",
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        )),
                  ],
                ),
              ),
              FutureBuilder(
                future: _trainingFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Training>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.data == null) {
                        return const Text("Empty");
                      }
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.4,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: snapshot.data!.map((training) {
                          return TrainingContainer(
                            referenceTraining: training,
                          );
                        }).toList(),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return const Center(child: Text("Error"));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Headline3(title: "Feed"),
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          "More...",
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FutureBuilder(
                    future: _feedFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return const Center(child: Text("Error"));
                          }
                          List<Training> trainings = snapshot.data;
                          return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 50),
                            shrinkWrap: true,
                            itemCount: trainings.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 200,
                                child: TrainingContainer(
                                  otherColor: true,
                                  referenceTraining: trainings[index],
                                ),
                              );
                            },
                          );
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return const Center(child: Text("Error"));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
