import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class OneRMPage extends StatefulWidget {
  static const routeName = "/1rm";
  const OneRMPage({Key? key}) : super(key: key);

  @override
  _OneRMPageState createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage> {
  double maxWeight = 100;
  late TextEditingController _textEditingController;
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
    _textEditingController.addListener(() {
      setState(() {
        maxWeight = double.parse(_textEditingController.text);
      });
    });
    super.initState();
  }

  List<Widget> _renderGridChildren() {
    List<Widget> children = [
      Text("Reps",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      Text("Percent",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      Text("Weight",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    ];
    for (int i = 0; i < matchingPercents.length; i++) {
      int reps = i + 1;
      double percent = matchingPercents[i];
      double weight = percent * maxWeight;
      children.addAll([
        Text(reps.toString(), style: const TextStyle()),
        Text((percent * 100).toInt().toString()),
        Text(weight.toString() + " kg"),
      ]);
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "100",
                          hintStyle: TextStyle(color: Colors.white60)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32.0),
                child: Text("Your 1RM is probably $maxWeight kg"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.count(
                      shrinkWrap: true,
                      // childAspectRatio: null,
                      crossAxisCount: 3,
                      children: _renderGridChildren()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
