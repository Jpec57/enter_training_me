import 'dart:async';
import 'dart:math';

import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuickCountdownPage extends StatefulWidget {
  static const routeName = "/quick-countdown";
  const QuickCountdownPage({Key? key}) : super(key: key);

  @override
  _QuickCountdownPageState createState() => _QuickCountdownPageState();
}

class _QuickCountdownPageState extends State<QuickCountdownPage>
    with SingleTickerProviderStateMixin {
  int _countdownValue = 0;
  int _totalTime = 0;
  late Timer _totalTimeTimer;
  int currentSet = 6;
  final List<int> availableDurations = [25, 60, 90, 120, 180];
  final maxSetCount = 7;
  late TabController _tabController;

  Widget _renderSetItem(int index) {
    Color bgColor = Colors.black;
    if (index == currentSet) {
      bgColor = CustomTheme.middleGreen;
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
        child: InkWell(
          onTap: () {
            setState(() {
              currentSet = index;
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
    if (currentSet > 0) {
      currentSet -= 1;
    }
    setState(() {
      _countdownValue = optionDuration;
    });
    _tabController.index = 1;
  }

  Widget _renderTimerOption(int optionDuration) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _selectTimer(optionDuration),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
            color: CustomTheme.middleGreen,
          ),
          child: Center(
            child: Text(
              optionDuration.toString(),
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _totalTimeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    //   setState(() {
    //     _totalTime = timer.tick;
    //     if (timer.tick >= 0) timer.cancel();
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _totalTimeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: _renderSetItems(),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: availableDurations
                        .map((duration) => _renderTimerOption(duration))
                        .toList()),
                CountdownTimer(
                  totalDuration: _countdownValue,
                  progressStrokeColor: CustomTheme.middleGreen,
                  size: min(MediaQuery.of(context).size.height * 0.5,
                      MediaQuery.of(context).size.width * 0.8),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
