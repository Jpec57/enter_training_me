import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/quick_countdown/total_time_info.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class QuickCountdownPage extends StatefulWidget {
  static const routeName = "/quick-countdown";
  const QuickCountdownPage({Key? key}) : super(key: key);

  @override
  _QuickCountdownPageState createState() => _QuickCountdownPageState();
}

class _QuickCountdownPageState extends State<QuickCountdownPage>
    with SingleTickerProviderStateMixin {
  final maxSetCount = 7;
  final List<int> availableDurations = [25, 60, 90, 120, 180, 300];
  late TabController _tabController;
  int _currentSet = 6;
  int _countdownValue = 0;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          CustomBottomNavigationBar.getCenteredFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
          selectedRoute: QuickCountdownPage.routeName),
      appBar: AppBar(
        // leading: const Icon(Icons.timer),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
        actions: const [
          Center(child: TotalTimeInfo()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.timer),
          )
        ],
      ),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: _renderSetItems(),
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              _renderTimerOption(availableDurations[0]),
                              _renderTimerOption(availableDurations[1]),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              _renderTimerOption(availableDurations[2]),
                              _renderTimerOption(availableDurations[3]),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              _renderTimerOption(availableDurations[4]),
                              _renderTimerOption(availableDurations[5]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: _countdownValue <= 0
                          ? Container()
                          : CountdownTimer(
                              backgroundColor: CustomTheme.darkGrey,
                              totalDuration: _countdownValue,
                              isIncludingStop: true,
                              onEndCallback: () {
                                setState(() {
                                  _tabController.index = 0;
                                });
                              },
                              progressStrokeColor: CustomTheme.middleGreen,
                            ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderSetItem(int index) {
    Color bgColor = Colors.black;
    if (index == _currentSet) {
      bgColor = CustomTheme.middleGreen;
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
        child: InkWell(
          onTap: () {
            setState(() {
              _currentSet = index;
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: CustomTheme.middleGreen)),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Center(
                  child: Text("$index",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)))),
        ),
      ),
    );
  }

  List<Widget> _renderSetItems() {
    List<Widget> setItems = [];
    for (int i = 0; i < maxSetCount; i++) {
      setItems.add(_renderSetItem(i));
    }
    return setItems;
  }

  void _selectTimer(int optionDuration) {
    if (_currentSet > 0) {
      _currentSet -= 1;
    }
    setState(() {
      _countdownValue = optionDuration;
    });
    _tabController.animateTo(1);
  }

  Widget _renderTimerOption(int optionDuration) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => _selectTimer(optionDuration),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
              color: CustomTheme.darkGrey,
            ),
            child: Center(
              child: Text(
                optionDuration.toString(),
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
