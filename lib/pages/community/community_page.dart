import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/tab_element.dart';
import 'package:enter_training_me/pages/community/bloc/community_tab_bloc.dart';
import 'package:enter_training_me/pages/community/views/coaching_view.dart';
import 'package:enter_training_me/pages/community/views/feed_view.dart';
import 'package:enter_training_me/pages/community/views/ranking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatefulWidget {
  static const routeName = "/community";
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  late TabController _innerTabController;

  @override
  void initState() {
    super.initState();
    _innerTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _innerTabController.dispose();
    super.dispose();
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
      body: BlocProvider(
        create: (context) => CommunityTabBloc(_innerTabController),
        child: CommunityPageContent(
          innerTabController: _innerTabController,
        ),
      ),
    );
  }
}

class CommunityPageContent extends StatelessWidget {
  final TabController innerTabController;

  const CommunityPageContent({Key? key, required this.innerTabController})
      : super(key: key);

  List<TabElement> getTabElements(BuildContext context) {
    return [
      TabElement(
          tab: const Tab(text: "Feed", icon: Icon(Icons.bloodtype)),
          view: const FeedView(),
          header: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/workouts/workout_wallpaper.jpeg"),
                    fit: BoxFit.cover)),
          )),
      TabElement(
          tab: const Tab(text: "Ranking", icon: Icon(Icons.computer)),
          view: const RankingView(),
          header: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/workouts/workout_wallpaper2.jpeg"),
                    fit: BoxFit.cover)),
          )),
      TabElement(
          tab: const Tab(text: "Coaching", icon: Icon(Icons.security)),
          view: const CoachingView(),
          header: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/workouts/workout_wallpaper3.jpeg"),
                    fit: BoxFit.cover)),
          )),
      TabElement(
          tab: const Tab(text: "Map", icon: Icon(Icons.map)),
          view: Container(color: Colors.green),
          header: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/workouts/workout_wallpaper4.jpeg"),
                    fit: BoxFit.cover)),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var tabElements = getTabElements(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
                controller: innerTabController,
                physics: const NeverScrollableScrollPhysics(),
                children: tabElements.map((e) => e.header!).toList()),
          ),
          TabBar(
              controller: innerTabController,
              tabs: tabElements.map((e) => e.tab).toList()),
          Expanded(
            flex: 3,
            child: TabBarView(
                controller: innerTabController,
                children: tabElements.map((e) => e.view).toList()),
          )
        ],
      ),
    );
  }
}
