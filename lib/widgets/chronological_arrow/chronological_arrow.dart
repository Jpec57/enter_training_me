import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/widgets/chronological_arrow/chronological_arrow_segment_painter.dart';
import 'package:enter_training_me/widgets/chronological_arrow/chronological_first_arrow_painter.dart';
import 'package:flutter/material.dart';

class ChronologicalArrow extends StatelessWidget {
  ChronologicalArrow({Key? key, this.currentSelectedIndex = 0}) : super(key: key);
  final int currentSelectedIndex;

  final List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  Widget _renderFirstArrow(bool isSelected) {
    return Container(
      color: Colors.black45,
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: CustomPaint(
            painter: ChronologicalFirstArrowPainter(
                isSelected: isSelected,
                selectedCircleColor: CustomTheme.darkerGreen)),
      ),
    );
  }

  Widget _renderArrowSegment(bool isSelected) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: CustomPaint(painter: ChronologicalArrowSegmentPainter()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int length = list.length;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width / 5,
            child: (index == length - 1)
                ? _renderFirstArrow(currentSelectedIndex == 0)
                : _renderArrowSegment(currentSelectedIndex == index),
          );
        });
  }
}
