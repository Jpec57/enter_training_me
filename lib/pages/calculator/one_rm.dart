import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

class OneRmCalculator extends StatefulWidget {
  const OneRmCalculator({Key? key}) : super(key: key);

  @override
  _OneRmCalculatorState createState() => _OneRmCalculatorState();
}

class _OneRmCalculatorState extends State<OneRmCalculator> {
  double givenWeight = 100;
  int _selectedRepNumber = 1;
  late FixedExtentScrollController _listWheelScrollController;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      if (_textEditingController.text.isNotEmpty) {
        setState(() {
          givenWeight = double.parse(_textEditingController.text);
        });
      }
    });

    _listWheelScrollController = FixedExtentScrollController();
    _listWheelScrollController.animateToItem((rmPercents.length ~/ 2),
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  void dispose() {
    _listWheelScrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  double _calculateOneRM() {
    return givenWeight / rmPercents[_selectedRepNumber - 1];
  }

  List<Widget> _renderGridChildren() {
    List<Widget> children = [];
    for (int i = 0; i < rmPercents.length; i++) {
      int reps = i + 1;
      double percent = rmPercents[i];

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
              ),
            ),
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
                  ...List.generate(rmPercents.length, (index) => index + 1)
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
          ],
        ),
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
                        onSelectedItemChanged: (int index) {},
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 75.0,
                        children: _renderGridChildren()))
              ],
            ),
          ),
        )
      ],
    );
  }
}
