import 'dart:async';
import 'dart:math';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/drawer.dart';
import 'package:enter_training_me/pages/quick_countdown/countdown_set_bat.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/countdown_timer/countdown_timer.dart';
import 'package:flutter/material.dart';

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
  late Timer _totalTimeTimer;
  int _currentSet = 6;
  int _countdownValue = 0;
  int _totalTime = 0;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _totalTimeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _totalTime = timer.tick;
      });
    });
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
  void dispose() {
    _tabController.dispose();
    _totalTimeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
        title: Text(Utils.convertToTime(_totalTime), style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      drawer: const MyDrawer(),
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
                  controller: _tabController, children: [
                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: availableDurations
                        .map((duration) => _renderTimerOption(duration))
                        .toList()),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountdownTimer(
                        totalDuration: _countdownValue,
                        onEndCallback: (){
                          _tabController.index = 0;
                        },
                        progressStrokeColor: CustomTheme.middleGreen,
                        size: min(MediaQuery.of(context).size.height * 0.5,
                            MediaQuery.of(context).size.width * 0.8),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomTheme.middleGreen
                          ),
                          child: IconButton(icon: const Icon(Icons.stop, color: CustomTheme.darkGrey,), onPressed: (){
                            _tabController.index = 0;
                          },),
                        ),
                      )
                    ],
                  ),
                ),

              ]),
            )
          ],
        ),
      ),
    );
  }
}
