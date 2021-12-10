import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class CountdownSetBar extends StatefulWidget {
  const CountdownSetBar({Key? key}) : super(key: key);

  @override
  _CountdownSetBarState createState() => _CountdownSetBarState();
}

class _CountdownSetBarState extends State<CountdownSetBar> {
  final maxSetCount = 7;
  int _currentSet = 6;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _renderSetItems(),
    );
  }
}
