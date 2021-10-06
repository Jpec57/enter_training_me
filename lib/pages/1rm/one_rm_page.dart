import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class OneRMPage extends StatefulWidget {
  static const routeName = "/1rm";
  const OneRMPage({Key? key}) : super(key: key);

  @override
  _OneRMPageState createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage> {
  double givenWeight = 100;
  int _selectedRepNumber = 1;
  late FixedExtentScrollController _listWheelScrollController;

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
      if (_textEditingController.text.isNotEmpty) {
        setState(() {
          givenWeight = double.parse(_textEditingController.text);
        });
      }
    });

    _listWheelScrollController = FixedExtentScrollController();
    _listWheelScrollController.animateToItem((matchingPercents.length ~/ 2),
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    super.initState();
  }

  double _calculateOneRM() {
    return givenWeight / matchingPercents[_selectedRepNumber - 1];
  }

  List<Widget> _renderGridChildren() {
    List<Widget> children = [];
    for (int i = 0; i < matchingPercents.length; i++) {
      int reps = i + 1;
      double percent = matchingPercents[i];

      double weight = percent * _calculateOneRM();
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Center(
                    child: Text(reps.toString(), style: const TextStyle()))),
            Expanded(
              child: Center(child: Text((percent * 100).toInt().toString())),
            ),
            Expanded(
              child: Center(child: Text(weight.toStringAsFixed(1) + " kg")),
            ),
          ],
        ),
      ));
      children.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(
          height: 1,
          color: Colors.white60,
        ),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          CustomBottomNavigationBar.getCenteredFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: "100",
                hintStyle: TextStyle(color: Colors.white60)),
          ),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: CustomTheme.darkGrey,
              ),
              child: DropdownButton<int>(
                value: _selectedRepNumber,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedRepNumber = newValue!;
                  });
                },
                items: <int>[
                  ...List.generate(
                      matchingPercents.length, (index) => index + 1)
                ].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      "${value}RM",
                    ),
                  );
                }).toList(),
              ),
            )
          ]),
      // drawer: const MyDrawer(),
      backgroundColor: CustomTheme.darkGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32.0),
                child: RichText(
                  text: TextSpan(text: "Your 1RM is probably ", children: [
                    TextSpan(
                        text: "${_calculateOneRM().toStringAsFixed(1)} kg",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Center(
                                child: Text("Reps",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text("Percent",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text("Weight",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListWheelScrollView(
                              controller: _listWheelScrollController,
                              onSelectedItemChanged: (int index) {
                                // print("Selected item is $index");
                              },
                              physics: const FixedExtentScrollPhysics(),
                              itemExtent: 75.0,
                              children: _renderGridChildren()))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
