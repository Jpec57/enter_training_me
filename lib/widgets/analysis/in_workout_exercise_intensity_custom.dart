import 'package:flutter/material.dart';

class InWorkoutExerciseIntensityCustom extends StatelessWidget {
  InWorkoutExerciseIntensityCustom({Key? key}) : super(key: key);
  static const kWidth = 50.0;
  static const kHeight = 300.0;
  final List<double> intensities = [20, 40, 60, 40, 100, 70];
  final List<double> refIntensities = [30, 20, 60, 30, 90, 70];
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.green
  ];

  Widget _renderBar(int index, double intensity) {
    return Container(
      width: kWidth,
      height: kHeight * (intensity / 100),
      color: colors[index % colors.length],
    );
  }

  Widget _renderRefBar(int index, double intensity) {
    return Container(
      width: kWidth,
      height: kHeight * (intensity / 100),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: colors[index % colors.length])),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bars = [];
    List<Widget> refBars = [];

    for (int i = 0; i < intensities.length; i++) {
      bars.add(_renderBar(i, intensities[i]));
      refBars.add(_renderRefBar(i, refIntensities[i]));
    }
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      height: kHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: bars,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: refBars,
          )
        ],
      ),
    );
  }
}
