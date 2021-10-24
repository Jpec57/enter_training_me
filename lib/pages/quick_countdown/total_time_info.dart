import 'dart:async';

import 'package:enter_training_me/utils/utils.dart';
import 'package:flutter/material.dart';

class TotalTimeInfo extends StatefulWidget {
  const TotalTimeInfo({Key? key}) : super(key: key);

  @override
  _TotalTimeInfoState createState() => _TotalTimeInfoState();
}

class _TotalTimeInfoState extends State<TotalTimeInfo>
    with SingleTickerProviderStateMixin {
  Timer? _totalTimeTimer;
  int _totalTime = 0;

  @override
  void initState() {
    initTimer();
    super.initState();
  }

  void initTimer() {
    _totalTimeTimer?.cancel();
    _totalTimeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _totalTime = timer.tick;
      });
    });
  }

  @override
  void dispose() {
    _totalTimeTimer?.cancel();
    _totalTimeTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      Utils.convertToTime(_totalTime),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
