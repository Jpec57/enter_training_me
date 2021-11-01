import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/training_container.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/texts/headline3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatefulWidget {
  static const routeName = "/community";
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late Future<List<Training>> _feedFuture;

  @override
  void initState() {
    super.initState();
    _feedFuture =
        RepositoryProvider.of<UserRepository>(context).getPersonalFeed();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _renderFeedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Headline4(title: "Feed"),
            InkWell(
                onTap: () {},
                child: const Text(
                  "More...",
                )),
          ],
        ),
        FutureBuilder(
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
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomBottomNavigationBar.getCenteredFloatingButton(
          isSelected: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedRoute: CommunityPage.routeName,
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [_renderFeedSection()],
          ),
        ),
      ),
    );
  }
}
