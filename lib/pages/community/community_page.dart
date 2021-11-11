import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/tab_element.dart';
import 'package:enter_training_me/pages/community/bloc/community_tab_bloc.dart';
import 'package:enter_training_me/pages/community/views/coaching_view.dart';
import 'package:enter_training_me/pages/community/views/feed_view.dart';
import 'package:enter_training_me/pages/community/views/ranking/ranking_view.dart';
import 'package:enter_training_me/widgets/animations/boolean_choice_widget.dart';
import 'package:enter_training_me/widgets/sliver/insta_like_sliver_delegate.dart';
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
    _innerTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _innerTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: showFab
          ? CustomBottomNavigationBar.getCenteredFloatingButton(
              isSelected: false)
          : null,
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
        header: BooleanChoiceWidget(
          animationDuration: const Duration(milliseconds: 300),
          leftWidget: (isSelected) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/workouts/workout_wallpaper2.jpeg"),
                      fit: BoxFit.cover)),
            );
          },
          rightWidget: (isSelected) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/workouts/workout_wallpaper3.jpeg"),
                      fit: BoxFit.cover)),
            );
          },
        ),
      ),
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
      // TabElement(
      //     tab: const Tab(text: "Map", icon: Icon(Icons.map)),
      //     view: Container(color: Colors.green),
      //     header: Container(
      //       decoration: const BoxDecoration(
      //           image: DecorationImage(
      //               image:
      //                   AssetImage("assets/workouts/workout_wallpaper4.jpeg"),
      //               fit: BoxFit.cover)),
      //     )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var tabElements = getTabElements(context);
    // final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return SafeArea(
      //https://stackoverflow.com/questions/54689594/flutter-tabsview-and-nestedscrollview-scroll-issue
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                background: TabBarView(
                    controller: innerTabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: tabElements.map((e) => e.header!).toList()),
              ),
            ),
            SliverPersistentHeader(
                delegate: InstaLikeSliverDelegate(TabBar(
                    controller: innerTabController,
                    tabs: tabElements.map((e) => e.tab).toList())),
                floating: true,
                pinned: true)
          ];
        },
        body: TabBarView(
            controller: innerTabController,
            children: tabElements.map((e) => e.view).toList()),
      ),
    );
  }
}
