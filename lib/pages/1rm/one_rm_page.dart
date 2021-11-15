import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/calculator/five_three_one.dart';
import 'package:enter_training_me/pages/calculator/one_rm.dart';
import 'package:flutter/material.dart';

class OneRMPage extends StatefulWidget {
  static const routeName = "/1rm";
  const OneRMPage({Key? key}) : super(key: key);

  @override
  _OneRMPageState createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage>
    with SingleTickerProviderStateMixin {
  late TabController _innerTabController;

  @override
  void initState() {
    _innerTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _innerTabController.dispose();
    super.dispose();
  }

  Widget _renderFiveThreeOneView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardDown = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      floatingActionButton: isKeyboardDown
          ? CustomBottomNavigationBar.getCenteredFloatingButton()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedRoute: OneRMPage.routeName,
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TabBar(controller: _innerTabController, tabs: const [
                Tab(
                  text: "OneRM",
                ),
                Tab(
                  text: "5-3-1",
                )
              ]),
              Expanded(
                child: TabBarView(
                    controller: _innerTabController,
                    children: const [
                      OneRmCalculator(),
                      FiveThreeOneCalculator()
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
