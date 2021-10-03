import 'package:carousel_slider/carousel_slider.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/drawer.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/training_container.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:enter_training_me/services/repositories/training_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Training>> _trainingFuture;

  @override
  void initState() {
    _trainingFuture =
        RepositoryProvider.of<TrainingRepository>(context).getAll();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      extendBody: true,
      drawer: const MyDrawer(),
      backgroundColor: CustomTheme.darkGrey,
      body: Column(
        children: [
          FutureBuilder(
            future: _trainingFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Training>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data == null) {
                    print("SNAP DATA");
                    print(snapshot.data);
                    return const Text("Empty");
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.4,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: snapshot.data!.map((training) {
                      return const TrainingContainer();
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
        ],
      ),
    );
  }
}
