import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class OneRMPage extends StatefulWidget {
  static const routeName = "/1rm";
  const OneRMPage({Key? key}) : super(key: key);

  @override
  _OneRMPageState createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage> {
  late TextEditingController _textEditingController;
  final percents = [100, 105, 110, 110, 115, 120, 120, 125, 125, 130];
  final List<double> matchingPercents = [
    1,
    0.97,
    0.94,
    0.92,
    0.89,
    0.86,
    0.83,
    0.81,
    0.78,
    0.75,
    0.73,
    0.71,
    0.7,
    0.68,
    0.67,
    0.65,
    0.64,
    0.63,
    0.61,
    0.6
  ];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "100"),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: matchingPercents.asMap().entries.map((e) {
                    int reps = e.key;
                    double percent = e.value;
                    return Container();
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
