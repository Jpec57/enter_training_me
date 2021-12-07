import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class FiveThreeOneCalculator extends StatefulWidget {
  const FiveThreeOneCalculator({Key? key}) : super(key: key);

  @override
  _FiveThreeOneCalculatorState createState() => _FiveThreeOneCalculatorState();
}

class _FiveThreeOneCalculatorState extends State<FiveThreeOneCalculator> {
  late TextEditingController _textEditingController;
  final List<List<double>> percents = [
    [0.65, 0.75, 0.85],
    [0.7, 0.80, 0.9],
    [0.75, 0.85, 0.95],
    [0.6, 0.6, 0.6],
    [0.65, 0.75, 0.85],
    [0.7, 0.80, 0.9],
    [0.75, 0.85, 0.95],
    [0.6, 0.6, 0.6],
  ];
  bool _isLowerLift = true;
  double _oneRM = 0;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      if (_textEditingController.text.isNotEmpty) {
        setState(() {
          _oneRM = double.parse(_textEditingController.text);
        });
      } else {
        setState(() {
          _oneRM = 0;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  String getRepStrForCell(int rowIndex, int columnIndex) {
    if (rowIndex % 4 == 0) {
      if (columnIndex == 2) {
        return "5+";
      }
      return "5";
    }
    if (rowIndex % 4 == 1) {
      if (columnIndex == 2) {
        return "3+";
      }
      return "3";
    }
    if (rowIndex % 4 == 2) {
      if (columnIndex == 0) {
        return "5";
      }
      if (columnIndex == 1) {
        return "3";
      }
      return "1+";
    }
    return "10";
  }

  double get trainingMax {
    var str = _textEditingController.text;
    if (str.isEmpty) {
      return 0;
    }
    return 0.9 * double.parse(str);
  }

  List<Widget> _renderProgramCells() {
    List<Widget> cells = [];
    for (var i = 0; i < percents.length; i++) {
      bool shouldAddWeight = percents.length / 2 <= i;
      double additionalWeight = shouldAddWeight ? (_isLowerLift ? 5 : 2.5) : 0;
      cells.addAll([
        Center(
            child: Text(
          "Week ${i + 1}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ]);

      for (int j = 0; j < percents[i].length; j++) {
        if (j % 4 == 3) {}
        cells.add(Center(
          child: Text("${getRepStrForCell(i, j)} @ " +
              (percents[i][j] * (trainingMax + additionalWeight))
                  .toStringAsFixed(1)),
        ));
      }
    }
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _cells = _renderProgramCells();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "OneRM",
                      hintStyle: TextStyle(color: Colors.white60)),
                ),
              ),
            ),
            Column(
              children: [
                Text(_isLowerLift ? "LOWER" : "UPPER"),
                Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isLowerLift,
                    onChanged: (value) {
                      setState(() {
                        _isLowerLift = !_isLowerLift;
                      });
                    }),
              ],
            )
          ],
        ),
        const Text("The calculus are based on a Training Max (TM) of "),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            "${trainingMax}kgs",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 50),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cells.length,
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          color: index % 8 < 4
                              ? CustomTheme.middleGreen
                              : CustomTheme.greenGrey,
                          border: Border.all(color: Colors.black, width: 0.5)),
                      child: _cells[index],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
